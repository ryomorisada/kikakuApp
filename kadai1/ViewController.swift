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
class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
        //以下カメラメソッド
    

        //シミュレーターで起動できるようにするコード
//        func configureCamera() -> Bool {
//            // init camera device
//            var captureDevice: AVCaptureDevice?
//            var devices: NSArray = AVCaptureDevice.devices() as NSArray
//            
//            // find back camera
//            for device: AnyObject in devices {
//                if device.position == AVCaptureDevicePosition.Back {
//                    captureDevice = device as? AVCaptureDevice
//                }
//            }
//            
//            if (captureDevice != nil) {
//                // Debug
//                print(captureDevice!.localizedName)
//                print(captureDevice!.modelID)
//            } else {
//                print("Missing Camera")
//                return false
//            }
//        }
        
//        // バックカメラからVideoInputを取得.
//        let videoInput = try! AVCaptureDeviceInput.init(device: myDevice)
//        // セッションに追加.
//        mySession.addInput(videoInput)
//        
//        // 出力先を生成.
//        myImageOutput = AVCaptureStillImageOutput()
//        
//        // セッションに追加.
//        mySession.addOutput(myImageOutput)
//        
//        // 画像を表示するレイヤーを生成.
//        let myVideoLayer = AVCaptureVideoPreviewLayer.init(session: mySession)
//        myVideoLayer?.frame = self.view.bounds
//        myVideoLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
//        
//        // Viewに追加.
//        self.view.layer.addSublayer(myVideoLayer!)
//        
//        // セッション開始.
//        mySession.startRunning()
//        
//        // UIボタンを作成.
//        let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
//        myButton.backgroundColor = UIColor.red
//        myButton.layer.masksToBounds = true
//        myButton.setTitle("撮影", for: .normal)
//        myButton.layer.cornerRadius = 20.0
//        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
//        myButton.addTarget(self, action: #selector(BtnPhoto), for: .touchUpInside)
//        
//        // UIボタンをViewに追加.
//        self.view.addSubview(myButton);
        
    
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func BtnCheck(_ sender: AnyObject) {
    
    }
    @IBAction func BtnPhoto(_ sender: AnyObject) {
        
        
        
        
        
        // ボタンイベント.
        func onClickMyButton(sender: UIButton){
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
            // バックカメラからVideoInputを取得.
            let videoInput = try! AVCaptureDeviceInput.init(device: myDevice)
            // セッションに追加.
            mySession.addInput(videoInput)
            
            // 出力先を生成.
            myImageOutput = AVCaptureStillImageOutput()
            
            // セッションに追加.
            mySession.addOutput(myImageOutput)
            
            // 画像を表示するレイヤーを生成.
            let myVideoLayer = AVCaptureVideoPreviewLayer.init(session: mySession)
            myVideoLayer?.frame = self.view.bounds
            myVideoLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            // Viewに追加.
            self.view.layer.addSublayer(myVideoLayer!)
            
            // セッション開始.
            mySession.startRunning()
            
            // UIボタンを作成.
            let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
            myButton.backgroundColor = UIColor.red
            myButton.layer.masksToBounds = true
            myButton.setTitle("撮影", for: .normal)
            myButton.layer.cornerRadius = 20.0
            myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
            myButton.addTarget(self, action: #selector(BtnPhoto), for: .touchUpInside)
            
            // UIボタンをViewに追加.
            self.view.addSubview(myButton);


            // ビデオ出力に接続.
            // let myVideoConnection = myImageOutput.connectionWithMediaType(AVMediaTypeVideo)
            let myVideoConnection = myImageOutput.connection(withMediaType: AVMediaTypeVideo)
            
            // 接続から画像を取得.
            self.myImageOutput.captureStillImageAsynchronously(from: myVideoConnection, completionHandler: {(imageDataBuffer, error) in
                if let e = error {
                    print(e.localizedDescription)
                    return
                }
                // 取得したImageのDataBufferをJpegに変換.
                let myImageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: imageDataBuffer!, previewPhotoSampleBuffer: nil)
                // JpegからUIIMageを作成.
                let myImage = UIImage(data: myImageData!)
                // アルバムに追加.
                UIImageWriteToSavedPhotosAlbum(myImage!, nil, nil, nil)
            })
        }
    }




    
    @IBAction func BtnAlbum(_ sender: AnyObject) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
