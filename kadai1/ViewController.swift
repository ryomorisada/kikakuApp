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
    //カメラ関係の変数定義
    var captureSesssion: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?

    
    
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
        

        
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func BtnCheck(_ sender: AnyObject) {
    
    }
    @IBAction func BtnPhoto(_ sender: AnyObject) {
//            // セッションの作成.
//            mySession = AVCaptureSession()
//            
//            // デバイス一覧の取得.
//            let devices = AVCaptureDevice.devices()
//            
//            // バックカメラをmyDeviceに格納.
//            for device in devices! {
//                if((device as AnyObject).position == AVCaptureDevicePosition.back){
//                    myDevice = device as! AVCaptureDevice
//                }
//            }
//            // バックカメラからVideoInputを取得.
//            let videoInput = try! AVCaptureDeviceInput.init(device: myDevice)
//            // セッションに追加.
//            mySession.addInput(videoInput)
//            
//            // 出力先を生成.
//            myImageOutput = AVCaptureStillImageOutput()
//            
//            // セッションに追加.
//            mySession.addOutput(myImageOutput)
//            
//            // 画像を表示するレイヤーを生成.
//            let myVideoLayer = AVCaptureVideoPreviewLayer.init(session: mySession)
//            myVideoLayer?.frame = self.view.bounds
//            myVideoLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
//            
//            // Viewに追加.
//            self.view.layer.addSublayer(myVideoLayer!)
//            
//            // UIボタンを作成.
//            let myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
//            myButton.backgroundColor = UIColor.red
//            myButton.layer.masksToBounds = true
//            myButton.setTitle("撮影", for: .normal)
//            myButton.layer.cornerRadius = 20.0
//            myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
//            myButton.addTarget(self, action: #selector(BtnPhoto), for: .touchUpInside)
//        
//        
//            // UIボタンをViewに追加.
//            self.view.addSubview(myButton);
//            // セッション開始.
//            mySession.startRunning()
//
//        // ビデオ出力に接続.
//        let myVideoConnection = myImageOutput.connection(withMediaType: AVMediaTypeVideo)
//        
//        // 接続から画像を取得.
//        self.myImageOutput.captureStillImageAsynchronously(from: myVideoConnection, completionHandler: { (imageDataBuffer, error) -> Void in
//            
//            // 取得したImageのDataBufferをJpegに変換.
//            let myImageData : NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer) as NSData
//            
//            // JpegからUIIMageを作成.
//            let myImage : UIImage = UIImage(data: myImageData as Data)!
//            
//            // アルバムに追加.
//            UIImageWriteToSavedPhotosAlbum(myImage, self, nil, nil)
//            
//        })
        // フラッシュとかカメラの細かな設定
        let settingsForMonitoring = AVCapturePhotoSettings()
        settingsForMonitoring.flashMode = .auto
        settingsForMonitoring.isAutoStillImageStabilizationEnabled = true
        settingsForMonitoring.isHighResolutionPhotoEnabled = false
        // シャッターを切る
        stillImageOutput?.capturePhoto(with: settingsForMonitoring, delegate: self as! AVCapturePhotoCaptureDelegate)
        
        captureSesssion = AVCaptureSession()
        stillImageOutput = AVCapturePhotoOutput()
        
        captureSesssion.sessionPreset = AVCaptureSessionPreset1920x1080 // 解像度の設定
        
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            
            // 入力
            if (captureSesssion.canAddInput(input)) {
                captureSesssion.addInput(input)
                
                // 出力
                if (captureSesssion.canAddOutput(stillImageOutput)) {
                    captureSesssion.addOutput(stillImageOutput)
                    captureSesssion.startRunning() // カメラ起動
                    
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSesssion)
                    previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect // アスペクトフィット
                    previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait // カメラの向き
                    
                    myImageView.layer.addSublayer(previewLayer!)
                    
                    // ビューのサイズの調整
                    previewLayer?.position = CGPoint(x: self.myImageView.frame.width / 2, y: self.myImageView.frame.height / 2)
                    previewLayer?.bounds = myImageView.frame
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    // デリゲート。カメラで撮影が完了した後呼ばれる。JPEG形式でフォトライブラリに保存。
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let photoSampleBuffer = photoSampleBuffer {
            // JPEG形式で画像データを取得
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
            let image = UIImage(data: photoData!)
            
            // フォトライブラリに保存
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
    }
    

    @IBAction func BtnAlbum(_ sender: AnyObject) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
