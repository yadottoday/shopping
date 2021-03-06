//
//  AppDelegate.swift
//  shopping
//
//  Created by 王庆华 on 15/12/10.
//  Copyright © 2015年 王庆华. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // 手动创建
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // 设置window 的根控制器
//       window?.rootViewController = UINavigationController(rootViewController: QHGoodListViewController())
        
        // 首页
        let FirstPage = FirstViewController()
        let navFirstPage = UINavigationController(rootViewController: FirstPage)
        navFirstPage.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "tabbar_icon_home"), tag: 1)
        
        // 货架
        let SecondPage = SecondViewController()
        let navSecondPage = UINavigationController(rootViewController: SecondPage)
        navSecondPage.tabBarItem = UITabBarItem(title: "货架", image: UIImage(named: "tabbar_icon_category"), tag: 2)
        
        
        // 购物车
        let ThirdPage = QHGoodListViewController()
        let navThirdPage = UINavigationController(rootViewController: ThirdPage)
        navThirdPage.tabBarItem = UITabBarItem(title: "购物车", image: UIImage(named: "tabbar_icon_cart"), tag: 3)
        
        // 我的
        let ForthPage = FourthViewController()
        let navFourthPage = UINavigationController(rootViewController: ForthPage)
        navFourthPage.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "tabbar_icon_mine"), tag: 4)
        
        
        
        let items = [navFirstPage,navSecondPage,navThirdPage,navFourthPage]
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = items
        
        window?.rootViewController = tabBarController
       
        // 设置window 为主窗口
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

