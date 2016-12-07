//
//  thirdViewController.swift
//  kadai1
//
//  Created by 森定遼 on 2016/11/15.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit

class thirdViewController: UIViewController {
    @IBOutlet weak var questionLable: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    var selectedIndex = -1
    var myGanre: NSArray = []
    var answerDistination1:Int = 0
    var answerDistination2:Int = 0
    var arr:NSArray = []
    var dic1:NSDictionary = ["":""]
    var dicTmp:NSDictionary = ["":""]
    var myAp = UIApplication.shared.delegate as! AppDelegate
    var currentGanre:String = ""
    
    override func viewDidLoad() {
        //グローバル変数からメンバ変数代入
        myGanre = myAp.myGanre as NSArray
        super.viewDidLoad()
    }
     override func viewWillAppear(_ animated: Bool) {
        //json.txtファイルを読み込んで
        let path = Bundle.main.path(forResource: "json", ofType: "txt")
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!))
        //配列データに変換して
        let jsonArray = (try! JSONSerialization.jsonObject(with: jsonData!, options: [])) as! NSArray
        //配列の個数だけ繰り返して表示する
        for dat in jsonArray {
            dicTmp = dat as! NSDictionary
            //if文(ジャンル)　質問1つ目
            if myGanre[selectedIndex] as! String == "服,靴" {
                if dicTmp["Genre"] as! String == "questionCloth" {
                    dic1 = dicTmp
                    currentGanre = dicTmp["Genre"] as! String
                    //answerDistination1,2にdic1から取り出した内容を代入す(次の質問に渡す準備をしている)
                    answerDistination1 = dic1["answerDistination1"]! as! Int
                    answerDistination2 = dic1["answerDistination2"]! as! Int
                    break
                }
            }
            if myGanre[selectedIndex] as! String == "本" {
                    if dicTmp["Genre"] as! String == "questionBook" {
                        dic1 = dicTmp
                        //answerDistination1,2にdic1から取り出した内容を代入する
                        currentGanre = dicTmp["Genre"] as! String
                        answerDistination1 = dic1["answerDistination1"]! as! Int
                        answerDistination2 = dic1["answerDistination2"]! as! Int
                        break
                }
            }
            if myGanre[selectedIndex] as! String == "電子機器" {
                if dicTmp["Genre"] as! String == "questionElc" {
                    dic1 = dicTmp
                    //answerDistination1,2にdic1から取り出した内容を代入する
                    currentGanre = dicTmp["Genre"] as! String
                    answerDistination1 = dic1["answerDistination1"]! as! Int
                    answerDistination2 = dic1["answerDistination2"]! as! Int
                    break
                }
            }
            if myGanre[selectedIndex] as! String == "ぬいぐるみ" {
                if dicTmp["Genre"] as! String == "questionDoll" {
                    dic1 = dicTmp
                    //answerDistination1,2にdic1から取り出した内容を代入する
                    currentGanre = dicTmp["Genre"] as! String
                    answerDistination1 = dic1["answerDistination1"]! as! Int
                    answerDistination2 = dic1["answerDistination2"]! as! Int
                    break
                }
            }
            if myGanre[selectedIndex] as! String == "文房具" {
                if dicTmp["Genre"] as! String == "questionStationery" {
                    dic1 = dicTmp
                    //answerDistination1,2にdic1から取り出した内容を代入する
                    currentGanre = dicTmp["Genre"] as! String
                    answerDistination1 = dic1["answerDistination1"]! as! Int
                    answerDistination2 = dic1["answerDistination2"]! as! Int
                    break
                }
            }
            if myGanre[selectedIndex] as! String == "化粧品" {
                if dicTmp["Genre"] as! String == "questionCosme" {
                    dic1 = dicTmp
                    //answerDistination1,2にdic1から取り出した内容を代入する
                    currentGanre = dicTmp["Genre"] as! String
                    answerDistination1 = dic1["answerDistination1"]! as! Int
                    answerDistination2 = dic1["answerDistination2"]! as! Int
                    break
                }
            }
            if myGanre[selectedIndex] as! String == "思い出の品" {
                if dicTmp["Genre"] as! String == "questionMemory" {
                    dic1 = dicTmp
                    //answerDistination1,2にdic1から取り出した内容を代入する
                    currentGanre = dicTmp["Genre"] as! String
                    answerDistination1 = dic1["answerDistination1"]! as! Int
                    answerDistination2 = dic1["answerDistination2"]! as! Int
                    break
                }
                print("値=[\(dat)]")
            }
            }
        //dic1を配列型に変換
        arr = dic1["question"] as! NSArray
        //questionLableにJSONに記載された配列の中身を表示
        questionLable.text = arr[0] as! String
        //textFieldに質問項目を表示
        textView.text = arr[1] as! String
    }
    
    @IBAction func yesBtn(_ sender: AnyObject) {
        //json.txtファイルを読み込んで
        let path = Bundle.main.path(forResource: "json", ofType: "txt")
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!))
        //配列データに変換して
        let jsonArray = (try! JSONSerialization.jsonObject(with: jsonData!, options: [])) as! NSArray
        //JSONの中の辞書の中の配列をオブジェクトとして定義
        dic1 = jsonArray[0] as! NSDictionary
        dicTmp = jsonArray[0] as! NSDictionary
        dic1 = dicTmp
        //画面遷移コード
        if answerDistination1 < 0 {
        //グローバル変数にanswerDistinationの値を代入する
        myAp.answerDistination1 = answerDistination1 as! Int
        myAp.answerDistination2 = 0
        //segueを使わない画面遷移
        let next: UIViewController = storyboard!.instantiateViewController(withIdentifier: "fourthViewController") as! UIViewController
        present(next, animated: true, completion: nil)
            }

        //for文を流す
        for dat in jsonArray {
            //json.txtファイルを読み込んで
            let path = Bundle.main.path(forResource: "json", ofType: "txt")
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!))
            
            //配列データに変換して
            let jsonArray = (try! JSONSerialization.jsonObject(with: jsonData!, options: [])) as! NSArray
            //dic1を配列型に変換
            arr = dic1["question"] as! NSArray
            dicTmp = dat as! NSDictionary
            //変数が正しく取れているか確認
            print("answerDistination1=\(answerDistination1)")
            print("questionNo=\(dicTmp["questionNo"] as! Int)")
            print("Genre=\(dicTmp["Genre"] as! String)")
            print("currentGanre=\(currentGanre)")
            
            //questionNoとanswerDistinationを比べるif文を記載
            if answerDistination1 == dicTmp["questionNo"] as! Int && currentGanre == dicTmp["Genre"] as! String {
                print("一致！")
                arr = dicTmp["question"] as! NSArray
                questionLable.text = arr[0] as! String
                textView.text = arr[1] as! String
                //次画面へ渡すデータの代入処理を記述
                currentGanre = dicTmp["Genre"] as! String
                answerDistination1 = dicTmp["answerDistination1"]! as! Int
                answerDistination2 = dicTmp["answerDistination2"]! as! Int
             break
            }
        }
    }
        @IBAction func nobtn(_ sender: UIButton) {
        //json.txtファイルを読み込んで
        let path = Bundle.main.path(forResource: "json", ofType: "txt")
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!))
        
        //配列データに変換して
        let jsonArray = (try! JSONSerialization.jsonObject(with: jsonData!, options: [])) as! NSArray
        
        //JSONの中の辞書の中の配列をオブジェクトとして定義
            dic1 = jsonArray[0] as! NSDictionary
            dicTmp = jsonArray[0] as! NSDictionary
            dic1 = dicTmp
        //画面遷移コード
        if answerDistination2 < 0 {
        //グローバル変数にanswerDistinationの値を代入する
        myAp.answerDistination1 = 0
        myAp.answerDistination2 = answerDistination2 as! Int
        //segueを使わない画面遷移
        let targetViewController = self.storyboard!.instantiateViewController(withIdentifier: "fourthViewController") as! UIViewController
        self.present( targetViewController,animated: true,completion: nil)
        }
        //for文を流す
        for dat in jsonArray {
            //json.txtファイルを読み込んで
            let path = Bundle.main.path(forResource: "json", ofType: "txt")
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!))
            
            //配列データに変換して
            let jsonArray = (try! JSONSerialization.jsonObject(with: jsonData!, options: [])) as! NSArray
            //dic1を配列型に変換
            arr = dic1["question"] as! NSArray
            dicTmp = dat as! NSDictionary
            print("answerDistination1=\(answerDistination1)")
            print("questionNo=\(dicTmp["questionNo"] as! Int)")
            print("Genre=\(dicTmp["Genre"] as! String)")
            print("currentGanre=\(currentGanre)")
            
            //questionNoとanswerDistinationを比べるif文を記載
            if answerDistination2 == dicTmp["questionNo"] as! Int && currentGanre == dicTmp["Genre"] as! String {
                print("一致！")
                arr = dicTmp["question"] as! NSArray
                questionLable.text = arr[0] as! String
                textView.text = arr[1] as! String
                //次画面へ渡すデータの代入処理を記述
                currentGanre = dicTmp["Genre"] as! String
                answerDistination1 = dicTmp["answerDistination1"]! as! Int
                answerDistination2 = dicTmp["answerDistination2"]! as! Int
                break
            }
        }
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
