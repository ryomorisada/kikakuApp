//
//  fifthViewController.swift
//  kadai1
//
//  Created by 森定遼 on 2016/11/20.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit
import Photos

class fifthViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate {
    var photoAssets = [PHAsset]()
    var myDefault = UserDefaults.standard
    var cell = customCellCollectionViewCell()
    var commentList: NSMutableArray = []
    var selectedUrl:String!
    var selectedComment:String!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.isHidden = true
        collectionView.backgroundColor = UIColor.clear
        //userDefaultの内容の取り出しの処理
        //蓄積されたデータがあったら
        if (myDefault.object(forKey: "commentList") != nil) {
        //データを取り出して、diaryListを更新(ダウンキャストで型変換)
        var commentListTmp: NSArray  = myDefault.object(forKey: "commentList") as! NSArray
        commentList = commentListTmp.mutableCopy() as! NSMutableArray
        }
        backgroundImage.image = UIImage(named:"room2.jpg")
        backgroundImage.alpha = 0.3
        
    }
        //セクション数を決める
        func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
     }
        //Item数を決める
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return commentList.count
     }
       //セルの中身を設定
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       //cellオブジェクトを作成
        let cell:customCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! customCellCollectionViewCell

       //端末のアルバムの中身を表示する処理
        let dicTmp:NSDictionary = commentList[indexPath.row] as! NSDictionary
        print(dicTmp)
        
        let strURL = dicTmp["picture"]! as! String
            print(strURL)
            
        if strURL != "" {
            let url = URL(string: strURL)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            if fetchResult.firstObject == nil{
                cell.myImage.image = UIImage(named:"noImage.jpg")
            } else{
                let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
                cell.setConfigure(assets: asset)
            }
        }
        
        //背景色の設定
        cell.backgroundColor = UIColor.black
        //設定したcellを返す
        return cell
    }
    
    
    @IBAction func returenMenu(segue:UIStoryboardSegue){
        
        if (myDefault.object(forKey: "commentList") != nil) {
            //データを取り出して、diaryListを更新(ダウンキャストで型変換)
            var commentListTmp: NSArray  = myDefault.object(forKey: "commentList") as! NSArray
            commentList = commentListTmp.mutableCopy() as! NSMutableArray
        }
    //再読み込みの処理
    collectionView.reloadData()
    
    
    }
//    @IBAction func tapImage(_ sender: AnyObject) {
//        //画面遷移
////        let imageViewController = self.storyboard!.instantiateViewController(withIdentifier: "imageViewController") as! UIViewController
////        self.present(imageViewController, animated: true, completion: nil)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goImage"{
        var row = collectionView.indexPathsForSelectedItems?[0][1]
        var selectedDic:NSDictionary = commentList[row!] as! NSDictionary
        print(selectedDic)
        let photoVC = (segue.destination as? imageViewController)!
        selectedUrl = selectedDic["picture"] as! String
        selectedComment = selectedDic["comment"] as! String
        print(selectedUrl)
        print(selectedComment)
        photoVC.selectedUrl = self.selectedUrl
        photoVC.selectedComment = self.selectedComment
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
