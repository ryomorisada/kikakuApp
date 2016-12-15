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

class cameraViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var cameraView: UIImageView!
    @IBOutlet weak var bCameraStart: UIButton!
    @IBOutlet weak var bSavePic: UIButton!
    @IBOutlet weak var bAlbum: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mytextView: UITextField!
    var commentList = NSMutableArray()
    var image:UIImage! = nil
    var commentArray:[NSDictionary] = []
    var commentDic:NSDictionary! = [:]
    var myDefault = UserDefaults.standard
    var selectedUrl = ""
    var localID = ""
    var commentListText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView.image = UIImage(named:"noImage.jpg")
        label.text = "カメラを押してカメラを起動してください"
        //        commentList[Dictionary] = nil
        mytextView.text = ""
        mytextView.placeholder = "コメントを入力してください"
        mytextView.delegate = self
        //蓄積されたデータがあったら
        //        //userDefault全削除
        //        myDefault.removeObject(forKey: "commentList")
        
        
        if (myDefault.object(forKey: "commentList") != nil){
            //データを取り出して、diaryListを更新(ダウンキャストで型変換)
            var commentListTmp: NSArray  = myDefault.object(forKey: "commentList") as! NSArray
            commentList = commentListTmp.mutableCopy() as! NSMutableArray
        }
        print(commentList)
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
        if (info[UIImagePickerControllerReferenceURL] != nil){
            
            //カメラロールから写真を選択
            print("カメラロールから選択")
            //アセットURL 保存
            let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]! as AnyObject
            self.selectedUrl = assetURL.description
            //画像を画面表示
            let url = URL(string: self.selectedUrl as String!)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            let manager: PHImageManager = PHImageManager()
            manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                self.cameraView.image = image
            }
            //閉じる処理
            imagePicker.dismiss(animated: true, completion: nil)
            label.text = "保存を押して写真を保存"
            return
        }
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            PHPhotoLibrary.shared().performChanges(
                { () -> Void in
                    // save the image
                    var assetChangeRequest:PHAssetChangeRequest = PHAssetCreationRequest.creationRequestForAsset(from: pickedImage)
                    self.localID = (assetChangeRequest.placeholderForCreatedAsset?.localIdentifier)!
                    print(self.localID)
                    // TODO how to get the asset url
                }, completionHandler:
                { (finished, error) -> Void in
                    if (finished)
                    {
                        print(self.localID)
                        self.selectedUrl = "assets-library://asset/asset.JPG?id="+self.localID+"&ext=JPG"
                        print(self.selectedUrl)
                        
                        //確認用
                        let url = URL(string: self.selectedUrl as String!)
                        let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
                        let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
                        let manager: PHImageManager = PHImageManager()
                        manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                            self.cameraView.image = image
                        }
                    }
                }
            )}
        print(info)
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
        //userDefaultに保存する処理
        myDefault = UserDefaults.standard
        commentListText = mytextView.text! as String
        // データを書き込んで
        commentList.add(["comment":commentListText,"picture":selectedUrl])
        print(commentList)
        myDefault.set(commentList, forKey: "commentList")
        // 即反映させる
        myDefault.synchronize()
        label.text = "保存しました"
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        label.text = textField.text
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    // アルバムを表示
    @IBAction func showAlbum(_ sender : AnyObject) {
        //Returnキー押下時の呼び出しメソッド
        func textFieldShouldReturn(textField:UITextField) -> Bool {
            //キーボードをしまう
            self.view.endEditing(true)
            //ラベルの文字列を保存する。
            myDefault.set(mytextView.text, forKey:"comment")
            //plistファイルへの出力と同期する。
            myDefault.synchronize()
            return false
        }
    }
    //カメラロールから写真を選択する処理
    @IBAction func cameraRollBtn(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            //写真ライブラリ(カメラロール)表示用のViewControllerを宣言
            let controller = UIImagePickerController()
            controller.delegate = self
            //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //トリミング
            controller.allowsEditing = true
            //新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goAlubum"){
            let fifthVC = (segue.destination as? fifthViewController)!
            let tmpDic = myDefault.dictionary(forKey: "comment")
            commentList.add(tmpDic)
            fifthVC.commentList = commentList
        }
        print(commentList)
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
