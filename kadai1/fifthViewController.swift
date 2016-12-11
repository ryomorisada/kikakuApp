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
    var comentList: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //userDefaultの内容の取り出しの処理
        //蓄積されたデータがあったら
        if (myDefault.object(forKey: "comentList") != nil) {
        //データを取り出して、diaryListを更新(ダウンキャストで型変換)
        var comentListTmp: NSMutableArray  = myDefault.object(forKey: "comentList") as! NSMutableArray
        comentList = comentListTmp.mutableCopy() as! NSMutableArray
        }
    }
        //セクション数を決める
        func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
     }
        //Item数を決める
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return comentList.count
     }
       //セルの中身を設定
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       //cellオブジェクトを作成
        let cell:customCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! customCellCollectionViewCell

       //端末のアルバムの中身を表示する処理
       //UserDefaultで番地指定しているので参照できるように読み込みが必要??
        let dicTmp:NSDictionary = comentList[indexPath.row] as! NSDictionary
        print(dicTmp)
            
        let strURL = dicTmp["picture"]!
        print(strURL)
            
        if strURL != nil{
            let url = URL(string: strURL as! String)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            cell.setConfigure(assets: asset)
        }
        
            
        //背景色の設定
        cell.backgroundColor = UIColor.black
        //設定したcellを返す
        return cell
    }
    
    @IBAction func tapImage(_ sender: AnyObject) {
        //segueを使わない画面遷移
        let imageViewController = self.storyboard!.instantiateViewController(withIdentifier: "imageViewController") as! UIViewController
        self.present(imageViewController, animated: true, completion: nil)
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
