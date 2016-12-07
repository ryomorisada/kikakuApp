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
import AVFoundation

class cameraViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cameraView: UIImageView!
    @IBOutlet weak var bCameraStart: UIButton!
    @IBOutlet weak var bSavePic: UIButton!
    @IBOutlet weak var bAlbum: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mytextView: UITextField!
    var comentList = NSMutableArray()
    var image:UIImage! = nil
    var comentArray:[NSDictionary] = []
    var comentDic:NSDictionary! = [:]
    var myDefault = UserDefaults.standard
    var selectedUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Startを押してカメラを起動してください"
        comentList = [["coment":"","picture":""]]
        mytextView.text = ""
        mytextView.placeholder = "コメントを入力してください"
        //蓄積されたデータがあったら
        if (myDefault.object(forKey: "comentList") != nil){
        //データを取り出して、diaryListを更新(ダウンキャストで型変換)
        var comentListTmp: NSMutableArray  = myDefault.object(forKey: "comentList") as! NSMutableArray
            comentList = comentListTmp.mutableCopy() as! NSMutableArray
        }
        print(comentList)
    }
    // カメラの撮影開始
    @IBAction func bCameraStart(_ sender : AnyObject) {
        let sourceType: UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = .camera
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
        else{
            label.text = "エラー"
        }
    }
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            cameraView.contentMode = .scaleAspectFit
            cameraView.image = pickedImage
        }
        //撮った写真を保存する処理を記載??
        
        
        

        let assetURL:AnyObject = info[UIImagePickerControllerOriginalImage] as! UIImage
//        selectedUrl = assetURL.description
        
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        label.text = "保存を押して写真を保存"
        }
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        label.text = "キャンセル"
    }
    // 写真を保存
    @IBAction func savePic(_ sender : AnyObject) {
        let image:UIImage! = cameraView.image
        if image != nil {
            if #available(iOS 9.3, *) {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(cameraViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
            } else {
            }
            //カメラロールで写真を選んだ後
//            func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//                let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]! as AnyObject
//                let strURL:String = assetURL.description
//                print(strURL)
//                // ユーザーデフォルトを用意する
//                myDefault = UserDefaults.standard
//                // データを書き込んで
//                comentList.add(["coment":mytextView.text,"picture":strURL])
//                myDefault.set(comentList, forKey: "coment")
//                myDefault.set(strURL, forKey: "selectedPhotoURL")
//                // 即反映させる
//                myDefault.synchronize()
//                //閉じる処理
//                imagePicker.dismiss(animated: true, completion: nil)
//            }

            //userDefaultに保存する処理
            myDefault = UserDefaults.standard
            // データを書き込んで
            comentList.add(["coment":mytextView.text,"picture":selectedUrl])
            myDefault.set(comentList, forKey: "comentList")
            // 即反映させる
            myDefault.synchronize()
//            //閉じる処理
//            imagePicker.dismiss(animated: true, completion: nil)
        }
        else{
            label.text = "保存に失敗しました"
        }
        
    }
    // 書き込み完了結果の受け取り
    func image(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        print("1")
        
        if error != nil {
            print(error.code)
            label.text = "保存に失敗しました"
        }
        else{
            label.text = "保存に成功しました"
        }
    }
    // アルバムを表示
    @IBAction func showAlbum(_ sender : AnyObject) {
        // UserDefaultからデータを取り出す
        let strURL = myDefault.string(forKey: "selectedPhotoURL")
        if strURL != nil{
            let url = URL(string: strURL as String!)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            let manager: PHImageManager = PHImageManager()
            manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) {(image, info) -> Void in
                self.cameraView.image = image
            }
        }
//        //カメラロールで写真を選んだ後
//        func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//            let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]! as AnyObject
//            let strURL:String = assetURL.description
//            print(strURL)            
//            // ユーザーデフォルトを用意する
//            myDefault = UserDefaults.standard
//            // データを書き込んで
//            comentList.add(["coment":mytextView.text,"picture":strURL])
//            myDefault.set(comentList, forKey: "coment")
//            myDefault.set(strURL, forKey: "selectedPhotoURL")
//            // 即反映させる
//            myDefault.synchronize()
//            //閉じる処理
//            imagePicker.dismiss(animated: true, completion: nil)
//        }
        //Returnキー押下時の呼び出しメソッド
        func textFieldShouldReturn(textField:UITextField) -> Bool {
            //キーボードをしまう
            self.view.endEditing(true)
            //ラベルの文字列を保存する。
            myDefault.set(mytextView.text, forKey:"coment")
            //plistファイルへの出力と同期する。
            myDefault.synchronize()
            return false
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goAlubum"){
            let fifthVC = (segue.destination as? fifthViewController)!
            let tmpDic = myDefault.dictionary(forKey: "coment")
            comentList.add(tmpDic)
            fifthVC.comentList = comentList
        }
        print(comentList)
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
