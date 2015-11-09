//
//  TopicDetailTableViewController.swift
//  Aggregate
//
//  Created by MAC on 15/10/30.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
import PKHUD

class TopicDetailTableViewController: UITableViewController {
    @IBOutlet weak var headerTitleLable: UILabel!
    @IBOutlet weak var headerContentLable: UILabel!
    @IBOutlet weak var headerMemberButton: UIButton!
    @IBOutlet weak var headerRepliesLable: UILabel!
    @IBOutlet weak var headerMemberImageView: UIImageView!
    @IBOutlet weak var headerMemberNameLable: UILabel!
    @IBOutlet weak var headerTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var headerContentHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    var topicId: String?
    var repliesArray = [Replies]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    //MARK:-初始化数据
    func initData() {
        if let topicId = topicId {
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.show()
            TopicDetailViewModel.shareTopicDetailViewModel().findTopicsInfo(topicId) {
                (content) in
                if let content = content {
                    self.initTopicInfo(content)
                }
            }
            TopicDetailViewModel.shareTopicDetailViewModel().findReplies(topicId, page: "\(0)") {
                (contentArray) in
                if let contentArray = contentArray where contentArray.count > 0 {
                    self.repliesArray = contentArray
                    self.tableView.reloadData()
                }
            }
        }
    }
    func initTopicInfo(content: Topic) {//初始化话题内容
        headerTitleLable.text = content.title
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(17)]
        headerTitleHeight.constant = headerTitleLable.text!.boundingRectWithSize(CGSizeMake(headerTitleLable.frame.size.width, 1000), options: option, attributes: attributes, context: nil).size.height + 2
        if let renderedContent = content.content_rendered!.dataUsingEncoding(NSUTF32StringEncoding, allowLossyConversion: false) {
            do {
                headerContentLable.attributedText = try NSAttributedString(data: renderedContent, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            } catch let error1 as NSError {
                print(error1)
            }
            headerContentHeight.constant = headerContentLable.attributedText!.boundingRectWithSize(CGSizeMake(headerContentLable.frame.size.width, 1000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil).size.height + 2
        }
        headerRepliesLable.text = content.replies
        if let imageURL = content.member_avatar_mini {
            ImageLoader.sharedLoader.imageForUrl("https:\(imageURL)", completionHandler:{(image: UIImage?, url: String) in
                self.headerMemberImageView.image = image
            })
        }
        headerMemberNameLable.text = content.member_username
        headerView.bounds = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 54 + headerContentHeight.constant + headerTitleHeight.constant)
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
        view.layoutIfNeeded()
        self.tableView.reloadData()
    }
    //MARK:-跳转用户详情
    @IBAction func mineUserInfoButtonClick(sender: UIButton) {
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "userInfoSegue" {
            if let cell = sender as? UITableViewCell {
                let topicDetail = segue.destinationViewController as! UserInfoViewController
                topicDetail.userInfoId = "\(cell.tag)"
            }
        }
    }
}
//MARK:-回复tableView代理
extension TopicDetailTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repliesArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicDetailCell", forIndexPath: indexPath) as! TopicDetailTableViewCell
        if repliesArray.count > indexPath.row {
            if let imageURL = repliesArray[indexPath.row].member_avatar_mini {
                ImageLoader.sharedLoader.imageForUrl("https:\(imageURL)", completionHandler:{(image: UIImage?, url: String) in
                    cell.memberImageView.image = image
                })
            }
            if let id = Int(repliesArray[indexPath.row].member_id!) {
                cell.tag = id
            }
            cell.memberNameLable.text = repliesArray[indexPath.row].member_username
            let option = NSStringDrawingOptions.UsesLineFragmentOrigin
            let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(15)]
            cell.memberNameWidth.constant = cell.memberNameLable.text!.boundingRectWithSize(CGSizeMake(1000, 18), options: option, attributes: attributes, context: nil).size.width + 2
            if let timeStr = Double(repliesArray[indexPath.row].created!) {
                let date = NSDate(timeIntervalSince1970: timeStr)
                cell.timeLable.text = HomeViewModel.shareHomeViewModel().initDate(date)
            }
            if let contentData = repliesArray[indexPath.row].content_rendered!.dataUsingEncoding(NSUTF32StringEncoding, allowLossyConversion: false) {
                do {
                    cell.contentLable.attributedText = try NSAttributedString(data: contentData, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
                } catch let error1 as NSError {
                    print(error1)
                }
                cell.contentHeight.constant = cell.contentLable.attributedText!.boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 52, 1000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil).size.height + 2
            }
        }
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if repliesArray.count > indexPath.row {
            if let contentData = repliesArray[indexPath.row].content_rendered!.dataUsingEncoding(NSUTF32StringEncoding, allowLossyConversion: false) {
                do {
                    return try NSAttributedString(data: contentData, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil).boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 52, 1000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil).size.height + 44
                } catch let error1 as NSError {
                    print(error1)
                    return 71
                }
            }else {
                return 71
            }
        }else {
            return 0
        }
    }
}
