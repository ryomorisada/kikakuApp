//
//  ViewController.swift
//  kadai1
//
//  Created by 森定遼 on 2016/11/04.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // セッション.
    var mySession : AVCaptureSession!
    // デバイス.
    var myDevice : AVCaptureDevice!
    // 画像のアウトプット.
    var myImageOutput: AVCaptureStillImageOutput!
    
    
    @IBOutlet weak var myImageView: UIImageView!
//    let myImage = UIImage(named: "")
//    let myImageView = UIImageView()
//    myImageView.image = myImage!
//    myImageView.frame = CGRectMake(0, 0, myImage!.size.width, myImage!.size.height)
//    self.view.addSubview(myImageView)
    

    
    
    override func viewDidLoad() {
        // セッションの作成.
        mySession = AVCaptureSession()
        
        // デバイス一覧の取得.
        let devices = AVCaptureDevice.devices()
        
        // バックカメラをmyDeviceに格納.
        for device in devices! {
            if((device as AnyObject).position == AVCaptureDevicePosition.back){
                myDevice = device as! AVCaptureDevice
            }
        }
       
        
        super.viewDidLoad()
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

