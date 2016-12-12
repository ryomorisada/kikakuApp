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
    var selectedUrl:String!
    var selectedComment:String!
    
    override func viewDidLoad() {
        //tapされたイメージとコメントを表示
        //userDefaultから？前の画面のイメージから？
        if selectedUrl != nil{
            let url = URL(string: selectedUrl)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
//            cell.setConfigure(assets: asset)
            let manager = PHImageManager()
            manager.requestImage(for: asset,
                                 targetSize: image.frame.size,
                                 contentMode: .aspectFill,
                                 options: nil,
                                 resultHandler: { [weak self] (image, info) in
                                    guard let wself = self, let outImage = image else {
                                        return
                                    }
                                    self?.image.image = image
                })            
        }
        label.text = selectedComment as! String
        print(selectedComment)

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: AnyObject) {
        let fifthViewController = self.storyboard!.instantiateViewController(withIdentifier: "fifthViewController")
        self.present(fifthViewController, animated: true, completion: nil)
    }
    //tapされたイメージを表示
    //userDefaultから？前の画面のイメージから？
//    image = selectedUrl
//    print(image)
//    label = selectedComment
//    print(selectedComment)
    
    

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