//
//  fifthViewController.swift
//  kadai1
//
//  Created by 森定遼 on 2016/11/20.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit
import Photos

class fifthViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var photoAssets = [PHAsset]()

    override func viewDidLoad() {
        super.viewDidLoad()

    
    
        // Do any additional setup after loading the view.
    }
    func getAllPhotosInfo() {
        photoAssets = []
        
//        // 画像をすべて取得
//        var assets: PHFetchResult = PHAsset.fetchAssets(with: .image, options: nil)
//        assets.enumerateObjects { (asset, index, stop) -> Void in
//            self.photoAssets.append(asset as PHAsset)
//        }
//        print(photoAssets)
    }
    

    //セクション数を決める
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Item数を決める
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    //セルの中身を設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //cellオブジェクトを作成
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UICollectionViewCell
        
        //背景色の設定
        cell.backgroundColor = UIColor.black
        //設定したcellを返す
        return cell
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
