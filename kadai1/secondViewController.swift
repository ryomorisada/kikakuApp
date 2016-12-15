//
//  secondViewController.swift
//  kadai1
//
//  Created by 森定遼 on 2016/11/14.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit

class secondViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var myGanre: NSArray = []
    var selectedIndex = -1
//    //画面遷移のための変数
//    let thirdViewController = thirdViewController()

    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        //Appにアクセス
        let myAp = UIApplication.shared.delegate as! AppDelegate
        //メンバ変数にグローバル変数から代入
        myGanre = myAp.myGanre as NSArray
        super.viewDidLoad()
    }
    //行数の指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGanre.count
    }
    //表示するセルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(myGanre[indexPath.row])"
        return cell
    }
    //選択されたときに行う処理(tableviewApp参照)answerに選択されたものを代入
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)行目が選択されました")
//         selectedIndex = indexPath.row   
//        performSegue(withIdentifier: "secondSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var indexPath = myTableView.indexPathForSelectedRow
        selectedIndex = (indexPath?.row)!
    //次画面へ渡すデータの代入処理を記述
        let secondVC = segue.destination as! thirdViewController
        secondVC.selectedIndex = selectedIndex
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
