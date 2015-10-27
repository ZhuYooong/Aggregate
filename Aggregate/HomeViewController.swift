//
//  HomeViewController.swift
//  Aggregate
//
//  Created by 朱勇 on 15/10/9.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
import DOHamburgerButton

class HomeViewController: UIViewController {
    var drawerAnimator: JVFloatingDrawerSpringAnimator?
    let hamburgerBtn = DOHamburgerButton()//显示节点按钮
    let buttonItem = Int(UIScreen.mainScreen().bounds.size.width / 60)//每行显示的节点数
    let nodeListNumber = 17
    var topicContentArray = [TopicInfo]()
    @IBOutlet weak var nodeHeight: NSLayoutConstraint!//下边的高度
    @IBOutlet weak var nodeCollectionView: UICollectionView!
    @IBOutlet weak var topicTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutMenuController()
        initItem()
    }
    //MARK:- 初始化控件
    func initItem() {
        nodeCollectionView.registerClass(NodeCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "nodeCell")
        HomeViewModel.shareHomeViewModel().findHotTopics() {
            (contentArray: [TopicInfo]?) in
            if let contentArray = contentArray where contentArray.count > 0 {
                self.title = "今日热议"
                self.topicContentArray = contentArray
                self.topicTableView.reloadData()
            }
        }
        topicTableView.tableFooterView = UIView()
    }
    func initTitle(cell: NodeCollectionViewCell, index: Int) {//标题
        if let tittleLable = cell.contentView.subviews[0] as? UILabel {
            title = tittleLable.text
        }
    }
    //MARK:- 与菜单界面相关的
    func aboutMenuController() {
        drawerAnimator = (UIApplication.sharedApplication().delegate as! AppDelegate).drawerAnimator
        configureAnimator()
        toMenuViewController()
    }
    func configureAnimator() {
        drawerAnimator?.animationDuration = 1
        drawerAnimator?.animationDelay = 0.00
        drawerAnimator?.initialSpringVelocity = 1
    }
    func toMenuViewController() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(swipeGesture)
    }
    func handleSwipeGesture(sender: UISwipeGestureRecognizer){
        if sender.direction == UISwipeGestureRecognizerDirection.Right {
            (UIApplication.sharedApplication().delegate as! AppDelegate).drawerViewController!.toggleDrawerWithSide(JVFloatingDrawerSide.Left, animated: true, completion: nil)
        }
    }
}
//MARK:- 节点列表代理
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nodeListNumber
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("nodeCell", forIndexPath: indexPath) as! NodeCollectionViewCell
        if indexPath.row == 0 {
            if cell.contentView.subviews.count == 0 {
                let nodeLable = UILabel(frame: CGRectMake(0, 0, 60, 40))
                nodeLable.textAlignment = NSTextAlignment.Center
                nodeLable.font = UIFont.systemFontOfSize(12)
                nodeLable.text = "今日热议"
                cell.contentView.addSubview(nodeLable)
            }
        }else if indexPath.row == 1 {
            if cell.contentView.subviews.count == 0 {
                let nodeLable = UILabel(frame: CGRectMake(0, 0, 60, 40))
                nodeLable.textAlignment = NSTextAlignment.Center
                nodeLable.font = UIFont.systemFontOfSize(12)
                nodeLable.text = "全部"
                cell.contentView.addSubview(nodeLable)
            }
        }else if indexPath.row == buttonItem - 1 {
            hamburgerBtn.frame = CGRectMake(0, -2, 60, 40)
            hamburgerBtn.color = UIColor.redColor()
            hamburgerBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
            hamburgerBtn.addTarget(self, action: "showOrHideNode:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.contentView.addSubview(hamburgerBtn)
        }else if indexPath.row == nodeListNumber - 1 {
            if cell.contentView.subviews.count == 0 {
                let moreLable = UILabel(frame: CGRectMake(0, 0, 60, 40))
                moreLable.textAlignment = NSTextAlignment.Center
                moreLable.font = UIFont.systemFontOfSize(12)
                moreLable.text = "全部节点……"
                cell.contentView.addSubview(moreLable)
            }
        }else {
            if cell.contentView.subviews.count == 0 {
                let nodeLable = UILabel(frame: CGRectMake(0, 0, 60, 40))
                nodeLable.textAlignment = NSTextAlignment.Center
                nodeLable.font = UIFont.systemFontOfSize(12)
                nodeLable.text = "潇洒的撒旦"
                cell.contentView.addSubview(nodeLable)
            }
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {//热点
            HomeViewModel.shareHomeViewModel().findHotTopics() {
                (contentArray: [TopicInfo]?) in
                if let contentArray = contentArray where contentArray.count > 0 {
                    self.topicContentArray = contentArray
                    self.topicTableView.reloadData()
                    self.title = "今日热议"
                }
            }
        }else if indexPath.row == 1 {//全部
            HomeViewModel.shareHomeViewModel().findLastestTopics() {
                (contentArray: [TopicInfo]?) in
                if let contentArray = contentArray where contentArray.count > 0 {
                    self.topicContentArray = contentArray
                    self.topicTableView.reloadData()
                    self.title = "全部"
                }
            }
        }else if indexPath.row == buttonItem - 1 {
        }else if indexPath.row == nodeListNumber - 1 {//跳转全部节点
            let allNodeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AllNodeID") as! AllNodeViewController
            allNodeViewController.didselectItem = {
                (array: [TopicInfo], titleStr: String) in
                self.topicContentArray = array
                self.topicTableView.reloadData()
                self.title = titleStr
            }
            navigationController?.pushViewController(allNodeViewController, animated: true)
        }else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("nodeCell", forIndexPath: indexPath) as! NodeCollectionViewCell
            initTitle(cell, index: indexPath.row)
        }
        showOrHideNode(hamburgerBtn)
    }
    func showOrHideNode(sender: DOHamburgerButton) {
        if self.nodeHeight.constant == 40 {//展开
            sender.select()
            UIView.animateWithDuration(0.2, animations: {
                () in
                let count = CGFloat(self.nodeListNumber) / CGFloat(self.buttonItem)
                self.nodeHeight.constant = 40 * ceil(count)
                self.view.layoutIfNeeded()
            })
        }else{//收缩
            sender.deselect()
            UIView.animateWithDuration(0.2, animations: {
                () in
                self.nodeHeight.constant = 40
                self.view.layoutIfNeeded()
            })
        }
    }
}
//MARK:- topic表代理
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicContentArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("topicCell", forIndexPath: indexPath) as! TopicTableViewCell
        if topicContentArray.count > indexPath.row {
            cell.topicContent.text = topicContentArray[indexPath.row].title
            cell.topicContentHeight.constant = HomeViewModel.shareHomeViewModel().initHeight(topicContentArray, index: indexPath.row)
            cell.userNameLable.text = topicContentArray[indexPath.row].member_username
            if let timeStr = Double(topicContentArray[indexPath.row].created!) {
                let date = NSDate(timeIntervalSince1970: timeStr)
                cell.topicTimeLable.text = HomeViewModel.shareHomeViewModel().initDate(date)
            }
            cell.nodeLable.text = topicContentArray[indexPath.row].node_title
            if let imageURL = topicContentArray[indexPath.row].member_avatar_mini {
                ImageLoader.sharedLoader.imageForUrl("https:\(imageURL)", completionHandler:{(image: UIImage?, url: String) in
                    cell.userIconImageView.image = image
                })
            }
            if let nodeText = cell.nodeLable.text {
                let option = NSStringDrawingOptions.UsesLineFragmentOrigin
                let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(12)]
                cell.nodeWidth.constant = nodeText.boundingRectWithSize(CGSizeMake(100, 16), options: option, attributes: attributes, context: nil).size.width + 2
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
        
    }
}