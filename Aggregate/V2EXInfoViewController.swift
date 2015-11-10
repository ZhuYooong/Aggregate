//
//  V2EXInfoViewController.swift
//  Aggregate
//
//  Created by MAC on 15/11/9.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class V2EXInfoViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey("V2EXUserName") as? String {
            performSegueWithIdentifier("MineUserInfoSegue", sender: self)
        }
    }
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        userNameTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
}
