//
//  ViewController.swift
//  Aggregate
//
//  Created by 朱勇 on 15/10/8.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initItem()
    }
    func initItem() {
        let split: SMTabbedSplitViewController = SMTabbedSplitViewController()
        let button = SMTabBarItem(actionBlock: {//添加按钮
            () in
            self.addTabButtonClick()
            }, image: UIImage(named: "add_icon"), andTitle: "Add")
        split.actionsButtons = [button]
        split.background = UIColor.whiteColor()
        let bundlePath = NSBundle.mainBundle().pathForResource("AggregateList", ofType: "plist")
        if let resultArray = NSArray(contentsOfFile: bundlePath!) {
            let V2EXTab = V2EXController()//V2EX
            var tabViewControllerList = [V2EXTab]
            for objectDic in resultArray {
                if let state = objectDic["state"] as? String where state == "1" {
                    if let name = objectDic["name"] as? String where name == "Sina" {
                        let viewController2 = UIViewController()
                        viewController2.view.backgroundColor = UIColor(red: 251 / 255, green: 73 / 255, blue: 71 / 255, alpha: 1)
                        let tab2 = SMTabBarItem(VC: viewController2, image: UIImage(named: "sina_icon"), andTitle: "sina")
                        tab2.selectedImage = UIImage(named: "sina_icon")
                        tabViewControllerList.append(tab2)
                    }
                }
            }
            split.tabsViewControllers = tabViewControllerList
        }
        navigationController?.pushViewController(split, animated: false)
    }
    func addTabButtonClick() {//添加按钮点击事件
        let addMenuCollectionViewController = UIStoryboard(name: "Menu", bundle: nil).instantiateViewControllerWithIdentifier("AddMenuControllerId") as! AddMenuCollectionViewController
        addMenuCollectionViewController.backLogIn = {
            addMenuCollectionViewController.navigationController?.dismissViewControllerAnimated(false, completion: nil)
        }
        let userInfoNaviation = UINavigationController(rootViewController: addMenuCollectionViewController)
        userInfoNaviation.navigationBar.barTintColor = UIColor(0x1F81F0)
        userInfoNaviation.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        userInfoNaviation.navigationBar.tintColor = UIColor.whiteColor()
        presentViewController(userInfoNaviation, animated: false, completion: nil)
    }
    //MARK: - 创建列表
    func V2EXController() -> SMTabBarItem {//V2EX
        if let mineName = NSUserDefaults.standardUserDefaults().objectForKey("V2EXUserName") as? String where mineName.characters.count > 0 {
            let V2EXUserInfoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserInfoViewController")
            V2EXUserInfoViewController.view.backgroundColor = UIColor.whiteColor()
            let V2EXTab = SMTabBarItem(VC: V2EXUserInfoViewController, image: UIImage(named: "V2EX_icon"), andTitle: "V2EX")
            V2EXTab.selectedImage = UIImage(named: "V2EX_icon")
            return V2EXTab
        }else {
            let infoViewController = UIStoryboard(name: "Menu", bundle: nil).instantiateViewControllerWithIdentifier("V2EXId") as! V2EXInfoViewController
            infoViewController.view.backgroundColor = UIColor.whiteColor()
            let V2EXTab = SMTabBarItem(VC: infoViewController, image: UIImage(named: "V2EX_icon"), andTitle: "V2EX")
            V2EXTab.selectedImage = UIImage(named: "V2EX_icon")
            return V2EXTab
        }
    }
}

