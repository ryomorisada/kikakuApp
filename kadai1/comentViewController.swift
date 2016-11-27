//
//  comentViewController.swift
//  kadai1
//
//  Created by 森定遼 on 2016/11/27.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit

class comentViewController: UIViewController {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTextView: UITextField!
    var comentList = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        comentList = [["coment":"","picture":""]]
        //userDefaultから保存した配列を取り出す
        
        //ユーザーデフォルトを用意
        var myDefault = UserDefaults.standard
        
        //UserDefaultを全削除する
        
        
        //蓄積されたデータがあったら
        if (myDefault.object(forKey: "comentList") != nil){
            
            //データを取り出して、diaryListを更新(ダウンキャストで型変換)
            var comentListTmp: NSMutableArray  = myDefault.object(forKey: "comentList") as! NSMutableArray
            comentList = comentListTmp.mutableCopy() as! NSMutableArray
        }
        print(comentList)
    }
        // Do any additional setup after loading the view.

    //保存ボタンが押されたとき
    @IBAction func saveBtn(_ sender: UIButton) {
        //タイトルを追加
        comentList.add(myTextView.text)
        print(comentList)
        
        //userDefaultに保存
        
        //ユーザーデフォルトを用意
        var myDefault = UserDefaults.standard
        //データを書き込んで
        myDefault.set(comentList,forKey: "comentList")
        //即反映させる
        myDefault.synchronize()
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
