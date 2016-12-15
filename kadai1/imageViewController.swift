//
//  imageViewController.swift
//  kadai1
//
//  Created by 森定遼 on 2016/12/11.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit
import Photos

class imageViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    var selectedUrl:String!
    var selectedComment:String!
    var myDefault = UserDefaults.standard
    var myAp = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        //tapされたイメージとコメントを表示
        if selectedUrl != ""{
            let url = URL(string: selectedUrl)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            if fetchResult.firstObject == nil{
                image.image = UIImage(named:"noImage.jpg")
            } else{
                let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
//                setConfigure(assets: asset)
                let manager = PHImageManager()
                    manager.requestImage(for: asset,targetSize: image.frame.size,contentMode: .aspectFill,options: nil) {(image,info) -> Void in self.image.image = image
                }
            }
        } else {
                image.image = UIImage(named:"noImage.jpg")
            }
        
        label.text = selectedComment as String
        print(selectedComment)
        backgroundImage.image = UIImage(named:"room03.jpg")
        label.backgroundColor = UIColor.white
        backgroundImage.alpha = 0.3
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //ここにuserDefaultから削除する処理を記載
    @IBAction func deleteBtn(_ sender: AnyObject) {
        //アラートを作る
        var alertController = UIAlertController(title: "確認", message:"本当に削除しますか？",preferredStyle: .alert)
        //OKボタンを追加
        alertController.addAction(UIAlertAction(title: "削除する",style: .default,handler: {action in self.myDelete()}))
        //キャンセルボタンを追加
        alertController.addAction (UIAlertAction (title: "キャンセル", style: .cancel, handler:{action in self.myCancel()}))
        //アラートを表示する(重要)
        present(alertController, animated: true,completion: nil)
        //削除ボタンが押された時に呼ばれるメゾッド
        

        
        
        
        
        
//        myDefault = myAp.myUserDafault
//        //データを取り出す
//        var commentListTmp: NSArray  = myDefault.object(forKey: "commentList") as! NSArray
//        var commentListEdit:NSMutableArray = commentListTmp.mutableCopy() as! NSMutableArray
//        var dicTmp:NSDictionary = ["comment":selectedComment,"picture":selectedUrl]
//        commentListEdit.remove(dicTmp)
//        //userDefaultに再度保存する
//        myDefault.set(commentListEdit, forKey: "commentList")
//        var alertController = UIAlertController(title: "完了", message:"写真が削除されました",preferredStyle: .alert)
        //        label.text = "写真が削除されました"
    }
    func myDelete() {
        myDefault = myAp.myUserDafault
        //データを取り出す
        var commentListTmp: NSArray  = myDefault.object(forKey: "commentList") as! NSArray
        var commentListEdit:NSMutableArray = commentListTmp.mutableCopy() as! NSMutableArray
        var dicTmp:NSDictionary = ["comment":selectedComment,"picture":selectedUrl]
        commentListEdit.remove(dicTmp)
        //userDefaultに再度保存する
        myDefault.set(commentListEdit, forKey: "commentList")
        var alertController = UIAlertController(title: "完了", message:"写真が削除されました",preferredStyle: .alert)
        print ("削除完了")
        label.text = "写真が削除されました"
    }
    //キャンセルボタンが押された時に呼ばれるメゾット
    func myCancel() {
        print ("削除をキャンセル")
    }

    
    @IBAction func backBtn(_ sender: AnyObject) {
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
