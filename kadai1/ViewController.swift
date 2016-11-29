//
//  ViewController.swift
//  kadai1
//
//  Created by 森定遼 on 2016/11/04.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit
import AVFoundation

@available(iOS 10.0, *)
class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,AVCapturePhotoCaptureDelegate {
    
    // セッション.
    var mySession : AVCaptureSession!
    // デバイス.
    var myDevice : AVCaptureDevice!
    // 画像のアウトプット.
    var myImageOutput: AVCaptureStillImageOutput!
    @IBOutlet weak var myImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //背景画面の指定
        myImageView.image = UIImage(named:"room01.jpg")
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
