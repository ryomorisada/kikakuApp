//
//  secondViewController.swift
//  kadai1
//
//  Created by 森定遼 on 2016/11/14.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit

class secondViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let myGanre = ["服,靴","本","電子機器","ぬいぐるみ","文房具","化粧品","思い出の品"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    
    
    //選択されたときに行う処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myGanre[indexPath.row])")
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
