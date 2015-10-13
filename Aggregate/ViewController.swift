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
        creatTabbedSplit()
    }
    //MARK:- 创建列表
    func creatTabbedSplit() {
        let split: SMTabbedSplitViewController = SMTabbedSplitViewController()
        let viewController1 = UIViewController()
        viewController1.view.backgroundColor = UIColor(red: 231 / 255, green: 231 / 255, blue: 231 / 255, alpha: 1)
        let tab1 = SMTabBarItem(VC: viewController1, image: UIImage(named: "V2EX_icon"), andTitle: "V2EX")
        tab1.selectedImage = UIImage(named: "V2EX_icon")
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = UIColor(red: 251 / 255, green: 73 / 255, blue: 71 / 255, alpha: 1)
        let tab2 = SMTabBarItem(VC: viewController2, image: UIImage(named: "sina_icon"), andTitle: "sina")
        tab2.selectedImage = UIImage(named: "sina_icon")
        let button = SMTabBarItem(actionBlock: {
            () in
            print("add")
            }, image: UIImage(named: "add_icon"), andTitle: "Add")
        split.tabsViewControllers = [tab1, tab2];
        split.actionsButtons = [button];
        split.background = UIColor.whiteColor()
        navigationController?.pushViewController(split, animated: false)
    }
}

