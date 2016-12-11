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
    
    override func viewDidLoad() {
        //tapされたイメージとコメントを表示
        //userDefaultから？前の画面のイメージから？
        

        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: AnyObject) {
        let fifthViewController = self.storyboard!.instantiateViewController(withIdentifier: "fifthViewController") as! UIViewController
        self.present(fifthViewController, animated: true, completion: nil)
    }
    //tapされたイメージを表示
    //userDefaultから？前の画面のイメージから？
    
    

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
