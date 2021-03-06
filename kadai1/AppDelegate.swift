//
//  AppDelegate.swift
//  kadai1
//
//  Created by 森定遼 on 2016/11/04.
//  Copyright © 2016年 森定遼. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let myGanre = ["服,靴","本","電子機器","ぬいぐるみ","文房具","化粧品","思い出の品"]
    //空っぽの変数
    let answer = ""
    //answerDistinationのグローバル変数定義
    var answerDistination1:Int = 0
    var answerDistination2:Int = 0
    //JSONの中身をグローバル変数で定義
    var arr:NSArray = []
    var dic1:NSDictionary = ["":""]
    var dicTmp: NSDictionary = ["":""]
    //UserDefaultsに関する処理
    var myUserDafault:UserDefaults = UserDefaults()
    //
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //登録されているUserDefaultに+1する
        let count:Int = myUserDafault.integer(forKey: "VisitCount") + 1
        
        //+1した値を登録する
        myUserDafault.set(count, forKey: "VisitCount")
        
        return true
    }
}


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

