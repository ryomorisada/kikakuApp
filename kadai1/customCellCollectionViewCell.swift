//
//  customCellCollectionViewCell.swift
//  kadai1
//
//  Created by 森定遼 on 2016/12/03.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit

class customCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myImage: UIImageView!
    
    required init(coder aDecoder: NSCoder){
    super.init(coder: aDecoder)!
    }
    override init(frame: CGRect){
        super.init(frame: frame)
    }
}