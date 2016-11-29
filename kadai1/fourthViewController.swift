//
//  fourthViewController.swift
//  kadai1
//
//  Created by 森定遼 on 2016/11/18.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit

class fourthViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var checkResultLabel: UITextField!
    @IBOutlet weak var resultLabel: UITextField!
    //Appにアクセス
    var myAp = UIApplication.shared.delegate as! AppDelegate
    
    //answerDistinationのメンバ変数定義
    var answerDistination1: Int! = 0
    var answerDistination2: Int! = 0
    
    override func viewDidLoad() {
        //Appにアクセス
        var myAp = UIApplication.shared.delegate as! AppDelegate
        
       
        //answerDistinationのメンバ変数定義
        answerDistination1 = myAp.answerDistination1 as! Int
        answerDistination2 = myAp.answerDistination2 as! Int
        
        

        
        myImageView.image = UIImage(named:"02.jpg")
        
        if answerDistination1 == -1 {
        resultLabel.text = "捨てる"
        }
        if answerDistination1 == -2 {
            resultLabel.text = "捨てない"
        }
        if answerDistination2 == -1 {
            resultLabel.text = "捨てる"
        }
        if answerDistination2 == -2 {
        resultLabel.text = "捨てない"
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func backMenuBtn(_ sender: UIButton) {
    }
    
    @IBAction func cameraBtn(_ sender: UIButton) {
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
