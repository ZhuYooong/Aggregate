//
//  ViewController.swift
//  Aggregate
//
//  Created by 朱勇 on 15/10/8.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isChanged = true
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if isChanged {
            creatTabbedSplit()
            isChanged = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - 创建列表
    func creatTabbedSplit() {
        let split: SMTabbedSplitViewController = SMTabbedSplitViewController()
        let V2EXTab = V2EXController()//V2EX
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = UIColor(red: 251 / 255, green: 73 / 255, blue: 71 / 255, alpha: 1)
        let tab2 = SMTabBarItem(VC: viewController2, image: UIImage(named: "sina_icon"), andTitle: "sina")
        tab2.selectedImage = UIImage(named: "sina_icon")
        //添加按钮
        let button = SMTabBarItem(actionBlock: {
            () in
            print("add")
            }, image: UIImage(named: "add_icon"), andTitle: "Add")
        split.tabsViewControllers = [V2EXTab, tab2]
        split.actionsButtons = [button]
        split.background = UIColor.whiteColor()
        navigationController?.pushViewController(split, animated: false)
    }
    func V2EXController() -> SMTabBarItem {//V2EX
        if let mineName = NSUserDefaults.standardUserDefaults().objectForKey("V2EXUserName") as? String where mineName.characters.count > 0 {
            let V2EXUserInfoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserInfoViewController")
            V2EXUserInfoViewController.view.backgroundColor = UIColor.whiteColor()
            let V2EXTab = SMTabBarItem(VC: V2EXUserInfoViewController, image: UIImage(named: "V2EX_icon"), andTitle: "V2EX")
            V2EXTab.selectedImage = UIImage(named: "V2EX_icon")
            return V2EXTab
        }else {
            let infoViewController = UIStoryboard(name: "Menu", bundle: nil).instantiateViewControllerWithIdentifier("V2EXId") as! V2EXInfoViewController
            infoViewController.isChanged = {
                (isLogIn) in
                self.isChanged = isLogIn
            }
            infoViewController.view.backgroundColor = UIColor.whiteColor()
            let V2EXTab = SMTabBarItem(VC: infoViewController, image: UIImage(named: "V2EX_icon"), andTitle: "V2EX")
            V2EXTab.selectedImage = UIImage(named: "V2EX_icon")
            return V2EXTab
        }
    }
}

