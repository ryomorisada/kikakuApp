//
//  ViewController.swift
//  kadai1
//
//  Created by 森定遼 on 2016/11/04.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        //背景画面の指定
        myImageView.image = UIImage(named:"room01.jpg")
        topLabel.backgroundColor = UIColor(white: 1.0, alpha: 0)
        bottomLabel.backgroundColor = UIColor(white: 1.0, alpha: 0)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func BtnCheck(_ sender: AnyObject) {
    }
    @IBAction func BtnPhoto(_ sender: AnyObject) {
    }
    @IBAction func BtnAlbum(_ sender: AnyObject) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
