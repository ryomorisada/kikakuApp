//
//  cameraViewController.swift
//  kadai1
//
//  Created by 森定遼 on 2016/11/29.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

class cameraViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cameraView: UIImageView!
    @IBOutlet weak var bCameraStart: UIButton!
    @IBOutlet weak var bSavePic: UIButton!
    @IBOutlet weak var bAlbum: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mytextView: UITextField!
    
    var comentList = NSMutableArray()
    // ユーザーデフォルトを用意する
    var myDefault = UserDefaults.standard
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Tap the [Start] to take a picture"
        
        comentList = [["coment":"","picture":""]]

        // Do any additional setup after loading the view.
    }

    @IBAction func bCameraStart(_ sender: UIButton) {
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            label.text = "error"
            
        }
    }
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            cameraView.contentMode = .scaleAspectFit
            cameraView.image = pickedImage
            
        }
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        label.text = "Tap the [Save] to save a picture"
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        label.text = "Canceled"
    }
    
    
    // 写真を保存
    @IBAction func savePic(_ sender : AnyObject) {
        let image:UIImage! = cameraView.image
        
        if image != nil {
            if #available(iOS 10.0, *) {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(cameraViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
            } else {
                // Fallback on earlier versions
            }
        }
        else{
            label.text = "image Failed !"
        }
        
    }
    
    // 書き込み完了結果の受け取り
    func image(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        print("1")
        
        if error != nil {
            print(error.code)
            label.text = "Save Failed !"
        }
        else{
            label.text = "Save Succeeded"
        }
    }
    
    // アルバムを表示
    @IBAction func showAlbum(_ sender : AnyObject) {
//        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
//        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
//            // インスタンスの作成
//            let cameraPicker = UIImagePickerController()
//            cameraPicker.sourceType = sourceType
//            cameraPicker.delegate = self
//            self.present(cameraPicker, animated: true, completion: nil)
//            
//            label.text = "Tap the [Start] to save a picture"
//        }
//        else{
//            label.text = "error"
//        }
        
        //UserDefaultから取り出す
        // ユーザーデフォルトを用意する
        var myDefault = UserDefaults.standard
        
        // データを取り出す
        let strURL = myDefault.string(forKey: "selectedPhotoURL")
        
        if strURL != nil{
            
            let url = URL(string: strURL as String!)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            let manager: PHImageManager = PHImageManager()
            manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                self.cameraView.image = image
            }
        }

        
    
    //カメラロールで写真を選んだ後
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]! as AnyObject
        
        let strURL:String = assetURL.description
        
        print(strURL)
        
        
        // ユーザーデフォルトを用意する
        myDefault = UserDefaults.standard
        
        // データを書き込んで
        myDefault.set(strURL, forKey: "selectedPhotoURL")
        
        // 即反映させる
        myDefault.synchronize()
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    //Returnキー押下時の呼び出しメソッド
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        
        //キーボードをしまう
        self.view.endEditing(true)
        
        //ラベルの文字列を保存する。
        myDefault.set(mytextView.text, forKey:"labelText")
        
        //plistファイルへの出力と同期する。
        myDefault.synchronize()
        
        return false
    }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
