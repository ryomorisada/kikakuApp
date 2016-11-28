//
//  comentViewController.swift
//  kadai1
//
//  Created by 森定遼 on 2016/11/27.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

class comentViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTextView: UITextField!
    var comentList = NSMutableArray()
    // ユーザーデフォルトを用意する
    var myDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comentList = [["coment":"","picture":""]]
    }
    
        // Do any additional setup after loading the view.

    //保存ボタンが押されたとき
    @IBAction func saveBtn(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {    //追記
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
    
    @IBAction func displayBtn(_ sender: UIButton) {
        //UserDefaultから取り出す
        // ユーザーデフォルトを用意する
        let myDefault = UserDefaults.standard
        
        // データを取り出す
        let strURL = myDefault.string(forKey: "selectedPhotoURL")
        
        if strURL != nil{
            
            let url = URL(string: strURL as String!)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            let manager: PHImageManager = PHImageManager()
            manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                self.myImage.image = image
            }
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
        myDefault.set(myTextView.text, forKey:"labelText")
        
        //plistファイルへの出力と同期する。
        myDefault.synchronize()
        
        return false
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
