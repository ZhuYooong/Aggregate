//
//  UserInfoViewController.swift
//  Aggregate
//
//  Created by MAC on 15/11/9.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
import PKHUD
typealias backToLogInFunc = () -> Void
class UserInfoViewController: UIViewController {
    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var userDescriptionLable: UILabel!
    @IBOutlet weak var mineTopicTableView: UITableView!
    var userInfoId: String?
    var userName: String?
    var topicContentArray = [Topic]()
    var backLogIn = backToLogInFunc?()
    override func viewDidLoad() {
        super.viewDidLoad()
        initItem()
        initData()
    }
    //MARK:初始化控件
    func initItem() {
        mineTopicTableView.tableFooterView = UIView()
        if let userName = userName where userName.characters.count > 0 {//特殊情况
            let crossBtn = UIButton(frame: CGRectMake(0,0,30,30))
            crossBtn.addTarget(self, action: "crossButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
            crossBtn.setImage(UIImage(named: "cross"), forState: UIControlState.Normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: crossBtn)
        }
    }
    func crossButtonClick(sender: UIButton) {
        backLogIn!()
    }
    @IBAction func exitButtonClick(sender: UIButton) {
        
    }
    //MARK:初始化数据
    func initData() {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        if let userInfoId = userInfoId {//别人的信息
            UserInfoViewModel.shareUserInfoViewModel().findmembers(userInfoId, username: nil, initData: { (content) -> Void in
                self.initMineData(content)
            })
        }else if let userName = userName {//自己的信息
            UserInfoViewModel.shareUserInfoViewModel().findmembers(nil, username: userName, initData: { (content) -> Void in
                self.initMineData(content)
                if let mineInfo = content {
                    NSUserDefaults.standardUserDefaults().setObject(mineInfo.username, forKey: "V2EXUserName")
                    UserInfoViewModel.shareUserInfoViewModel().insertMineInfo(mineInfo)
                }
            })
        }else if let mineName = NSUserDefaults.standardUserDefaults().objectForKey("V2EXUserName") as? String {//默认的信息
            UserInfoViewModel.shareUserInfoViewModel().findMineInfo(mineName, mineInfo: { (user) -> Void in
                self.initMineData(user)
            })
        }
    }
    func initMineData(mineInfo: User?) {
        self.title = mineInfo?.username
        self.userNameLable.text = mineInfo?.username
        self.userDescriptionLable.text = mineInfo?.bio
        if let imageURL = mineInfo?.avatar_large {
            ImageLoader.sharedLoader.imageForUrl("https:\(imageURL)", completionHandler:{(image: UIImage?, url: String) in
                self.userIconImageView.image = image
            })
        }
        HomeViewModel.shareHomeViewModel().findNodeTopics(self.userNameLable.text, nodeId: nil, nodeName: nil, initData: { (contentArray) -> Void in
            if let contentArray = contentArray {
                self.topicContentArray = contentArray
                self.mineTopicTableView.reloadData()
            }
        })
    }
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
//MARK: - 话题列表代理
extension UserInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicContentArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userInfoCell", forIndexPath: indexPath) as! UserInfoTableViewCell
        if topicContentArray.count > indexPath.row {
            if let id = Int(topicContentArray[indexPath.row].id!) {
                cell.tag = id
            }
            cell.topicTitleLable.text = topicContentArray[indexPath.row].title
            cell.topicTitleHeight.constant = HomeViewModel.shareHomeViewModel().initHeight(topicContentArray, index: indexPath.row)
            if let timeStr = Double(topicContentArray[indexPath.row].created!) {
                let date = NSDate(timeIntervalSince1970: timeStr)
                cell.timeLable.text = HomeViewModel.shareHomeViewModel().initDate(date)
            }
            cell.nodeNameLable.text = topicContentArray[indexPath.row].node_title
            if let nodeText = cell.nodeNameLable.text {
                let option = NSStringDrawingOptions.UsesLineFragmentOrigin
                let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(12)]
                cell.nodeNameWidth.constant = nodeText.boundingRectWithSize(CGSizeMake(100, 16), options: option, attributes: attributes, context: nil).size.width + 2
            }
            view.layoutIfNeeded()
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if topicContentArray.count > indexPath.row {
            let contentHeight = HomeViewModel.shareHomeViewModel().initHeight(topicContentArray, index: indexPath.row)
            return contentHeight + 40
        }else {
            return 77
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let id = topicContentArray[indexPath.row].id {
            let topicDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TopicDetailId") as! TopicDetailTableViewController
            topicDetailViewController.topicId = id
            topicDetailViewController.hidesBottomBarWhenPushed = false
            navigationController?.pushViewController(topicDetailViewController, animated: true)
        }
    }
}