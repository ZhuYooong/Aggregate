//
//  MainDrawViewController.swift
//  Aggregate
//
//  Created by 朱勇 on 15/10/9.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class MainDrawViewController: JVFloatingDrawerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainDrawViewController.changeBackgroundColor(_:)), name: "selectedColor", object: nil)
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "selectedColor:", object: nil)
    }
    func changeBackgroundColor(notification: NSNotification){
        if let colorDic = notification.userInfo as? [String: UIColor] {
            self.view.backgroundColor = colorDic["selectedColor"]
        }
    }
    
}
