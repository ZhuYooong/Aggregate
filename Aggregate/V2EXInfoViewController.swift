//
//  V2EXInfoViewController.swift
//  Aggregate
//
//  Created by MAC on 15/11/9.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
import PKHUD

class V2EXInfoViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey("V2EXUserName") as? String {
            performSegueWithIdentifier("MineUserInfoSegue", sender: self)
        }
    }
    @IBAction func logInButtonClick(sender: UIButton) {
        if userNameTextField.text?.characters.count > 0 {
            performSegueWithIdentifier("MineUserInfoSegue", sender: self)
        }else {
            PKHUD.sharedHUD.contentView = PKHUDTextView(text: "请填写您的用户名")
            PKHUD.sharedHUD.show()
            PKHUD.sharedHUD.hide(afterDelay: 1.0)
        }
    }
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MineUserInfoSegue" {
            let userInfoViewController = segue.destinationViewController as! UserInfoViewController
            if let mineName = NSUserDefaults.standardUserDefaults().objectForKey("V2EXUserName") as? String {
                userInfoViewController.userName = mineName
            }else {
                userInfoViewController.userName = userNameTextField.text
            }
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        userNameTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
}
