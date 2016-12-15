//
//  customCellCollectionViewCell.swift
//  kadai1
//
//  Created by 森定遼 on 2016/12/03.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit
import Photos

class customCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    required init(coder aDecoder: NSCoder){
    super.init(coder: aDecoder)!
    }
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // 画像を表示する
    func setConfigure(assets: PHAsset) {
        let manager = PHImageManager()
        
        manager.requestImage(for: assets,targetSize: frame.size,contentMode: .aspectFill,options: nil,resultHandler: { [weak self] (image, info) in
    guard let wself = self, let outImage = image else {
                                    return
                                }
                                self?.myImage.image = image
            })
    }
}
