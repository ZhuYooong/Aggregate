//
//  V2EXInfoViewController.swift
//  Aggregate
//
//  Created by MAC on 15/11/9.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
import PKHUD
import HxColor
typealias logInfunc = (Bool) ->Void
class V2EXInfoViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var isChanged = logInfunc?()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func logInButtonClick(sender: UIButton) {
        if userNameTextField.text?.characters.count > 0 {
            let V2EXUserInfoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserInfoViewController") as! UserInfoViewController
            let userInfoNaviation = UINavigationController(rootViewController: V2EXUserInfoViewController)
            userInfoNaviation.navigationBar.barTintColor = UIColor(0x1F81F0)
            userInfoNaviation.navigationBar.titleColor = UIColor.whiteColor()
            if let mineName = NSUserDefaults.standardUserDefaults().objectForKey("V2EXUserName") as? String {
                V2EXUserInfoViewController.userName = mineName
            }else {
                V2EXUserInfoViewController.userName = userNameTextField.text
            }
            presentViewController(userInfoNaviation, animated: false, completion: nil)
            isChanged!(true)
        }else {
            PKHUD.sharedHUD.contentView = PKHUDTextView(text: "请填写您的用户名")
            PKHUD.sharedHUD.show()
            PKHUD.sharedHUD.hide(afterDelay: 1.0)
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        userNameTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
}
