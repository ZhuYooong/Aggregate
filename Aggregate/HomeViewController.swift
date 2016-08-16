//
//  HomeViewController.swift
//  Aggregate
//
//  Created by 朱勇 on 15/10/9.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
import DOHamburgerButton
import PKHUD
import WatchConnectivity
import KFSwiftImageLoader

class HomeViewController: UIViewController {
    var drawerAnimator: JVFloatingDrawerSpringAnimator?
    let hamburgerBtn = DOHamburgerButton()//显示节点按钮
    let buttonItem = Int(UIScreen.mainScreen().bounds.size.width / 60)//每行显示的节点数
    var nodeListNumber = 4
    var topicContentArray = [Topic]()
    var mineNodeArray = [Node]()
    var currentNum = 0
    var isEdit = true//是否刷新节点
    var session: WCSession?//在 iOS app 中启动 session
    @IBOutlet weak var nodeHeight: NSLayoutConstraint!//下边的高度
    @IBOutlet weak var nodeCollectionView: UICollectionView!
    @IBOutlet weak var topicTableView: UITableView!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        initNodeData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutMenuController()
        initItem()
    }
    //MARK:- 初始化控件
    func initNodeData() {
        if isEdit {
            mineNodeArray = HomeViewModel.shareHomeViewModel.initMineNode()
            nodeListNumber = mineNodeArray.count + 4
            AllNodeViewModel.shareAllNodeViewModel.findMineNode() {
                (mineNodeContentArr) in
                if mineNodeContentArr.count > 0 {
                    self.mineNodeArray = mineNodeContentArr
                    self.nodeListNumber = self.mineNodeArray.count + 4
                }
                do {
                    try self.session?.updateApplicationContext(["MineNode": self.mineNodeArray])
                } catch _ {
                    
                }
                self.currentNum = 0
                self.isEdit = false
                self.nodeCollectionView.reloadData()
            }
        }
    }
    func initItem() {
        //在 iOS app 中启动 session
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session!.delegate = self
            session!.activateSession()
        }
        //node列表
        nodeCollectionView.registerClass(NodeCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "nodeCell")
        //topic列表
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        HomeViewModel.shareHomeViewModel.findHotTopics() {
            (contentArray: [Topic]?) in
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
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(HomeViewController.handleSwipeGesture(_:)))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(swipeGesture)
    }
    func handleSwipeGesture(sender: UISwipeGestureRecognizer){
        if sender.direction == UISwipeGestureRecognizerDirection.Right {
            (UIApplication.sharedApplication().delegate as! AppDelegate).drawerViewController!.toggleDrawerWithSide(JVFloatingDrawerSide.Left, animated: true, completion: nil)
        }
    }
    //MARK: - 节点列表
    func showOrHideNode(sender: DOHamburgerButton) {
        if self.nodeHeight.constant == 40 {//展开
            sender.select()
            UIView.animateWithDuration(0.2, animations: {
                () in
                let count = CGFloat(self.nodeListNumber) / CGFloat(self.buttonItem)
                self.nodeHeight.constant = 40 * ceil(count)
                self.view.layoutIfNeeded()
            })
        }else {//收缩
            hideNode(sender)
        }
    }
    func hideNode(sender: DOHamburgerButton) {
        sender.deselect()
        UIView.animateWithDuration(0.2, animations: {
            () in
            self.nodeHeight.constant = 40
            self.view.layoutIfNeeded()
        })
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell where segue.identifier == "topicDetailSegue" {
            let topicDetail = segue.destinationViewController as! TopicDetailTableViewController
            topicDetail.topicId = "\(cell.tag)"
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
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        if indexPath.row == 0 {
            let nodeLable = UILabel(frame: CGRectMake(0, 0, 60, 40))
            nodeLable.textAlignment = NSTextAlignment.Center
            nodeLable.font = UIFont.systemFontOfSize(12)
            nodeLable.text = "今日热议"
            cell.contentView.addSubview(nodeLable)
        }else if indexPath.row == 1 {
            let nodeLable = UILabel(frame: CGRectMake(0, 0, 60, 40))
            nodeLable.textAlignment = NSTextAlignment.Center
            nodeLable.font = UIFont.systemFontOfSize(12)
            nodeLable.text = "全部"
            cell.contentView.addSubview(nodeLable)
        }else if indexPath.row == buttonItem - 1 && buttonItem != nodeListNumber {
            hamburgerBtn.frame = CGRectMake(0, -2, 60, 40)
            hamburgerBtn.color = UIColor.redColor()
            hamburgerBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
            hamburgerBtn.addTarget(self, action: #selector(HomeViewController.showOrHideNode(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            cell.contentView.addSubview(hamburgerBtn)
        }else if indexPath.row == nodeListNumber - 1 {
            let moreLable = UILabel(frame: CGRectMake(0, 0, 60, 40))
            moreLable.textAlignment = NSTextAlignment.Center
            moreLable.font = UIFont.systemFontOfSize(12)
            moreLable.text = "全部节点……"
            cell.contentView.addSubview(moreLable)
        }else {
            if nodeListNumber > indexPath.row && mineNodeArray.count > currentNum {
                let nodeLable = UILabel(frame: CGRectMake(0, 0, 60, 40))
                nodeLable.tag = currentNum
                nodeLable.textAlignment = NSTextAlignment.Center
                nodeLable.font = UIFont.systemFontOfSize(12)
                nodeLable.text = mineNodeArray[currentNum].title
                cell.contentView.addSubview(nodeLable)
                currentNum += 1
            }
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {//热点
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.show()
            HomeViewModel.shareHomeViewModel.findHotTopics() {
                (contentArray: [Topic]?) in
                if let contentArray = contentArray where contentArray.count > 0 {
                    self.topicContentArray = contentArray
                    self.topicTableView.reloadData()
                    self.title = "今日热议"
                }
            }
        }else if indexPath.row == 1 {//全部
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.show()
            HomeViewModel.shareHomeViewModel.findLastestTopics() {
                (contentArray: [Topic]?) in
                if let contentArray = contentArray where contentArray.count > 0 {
                    self.topicContentArray = contentArray
                    self.topicTableView.reloadData()
                    self.title = "全部"
                }
            }
        }else if indexPath.row == buttonItem - 1 && buttonItem != nodeListNumber {
        }else if indexPath.row == nodeListNumber - 1 {//跳转全部节点
            let allNodeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AllNodeID") as! AllNodeViewController
            allNodeViewController.didselectItem = {
                (array: [Topic]?, titleStr: String?, isEdit: Bool) in
                if let array = array, titleStr = titleStr {
                    self.topicContentArray = array
                    self.topicTableView.reloadData()
                    self.title = titleStr
                }
                self.isEdit = isEdit
            }
            navigationController?.pushViewController(allNodeViewController, animated: true)
        }else {//我的节点
            if nodeListNumber > indexPath.row {
                let cell = collectionView.cellForItemAtIndexPath(indexPath) as! NodeCollectionViewCell
                if let tittleLable = cell.contentView.subviews[0] as? UILabel where mineNodeArray.count > tittleLable.tag {
                    let id = mineNodeArray[tittleLable.tag].id
                    PKHUD.sharedHUD.contentView = PKHUDProgressView()
                    PKHUD.sharedHUD.show()
                    HomeViewModel.shareHomeViewModel.findNodeTopics(nil, nodeId: id, nodeName: nil, initData: {
                        (contentArray: [Topic]?) in
                        self.topicContentArray = contentArray!
                        self.topicTableView.reloadData()
                        self.title = tittleLable.text
                    })
                }
            }
        }
        hideNode(hamburgerBtn)
    }
}
//MARK: - topic表代理
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicContentArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("topicCell", forIndexPath: indexPath) as! TopicTableViewCell
        if topicContentArray.count > indexPath.row {
            if let id = Int(topicContentArray[indexPath.row].id!) {
                cell.tag = id
            }
            cell.topicContent.text = topicContentArray[indexPath.row].title
            cell.topicContentHeight.constant = HomeViewModel.shareHomeViewModel.initHeight(topicContentArray, index: indexPath.row)
            cell.userNameLable.text = topicContentArray[indexPath.row].member_username
            if let timeStr = Double(topicContentArray[indexPath.row].created!) {
                let date = NSDate(timeIntervalSince1970: timeStr)
                cell.topicTimeLable.text = HomeViewModel.shareHomeViewModel.initDate(date)
            }
            cell.nodeLable.text = topicContentArray[indexPath.row].node_title
            if let imageURL = topicContentArray[indexPath.row].member_avatar_mini {
                cell.userIconImageView.loadImageFromURLString("https:\(imageURL)")
            }
            if let nodeText = cell.nodeLable.text {
                let option = NSStringDrawingOptions.UsesLineFragmentOrigin
                let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(12)]
                cell.nodeWidth.constant = nodeText.boundingRectWithSize(CGSizeMake(100, 16), options: option, attributes: attributes, context: nil).size.width + 2
            }
            view.setNeedsLayout()
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if topicContentArray.count > indexPath.row {
            let contentHeight = HomeViewModel.shareHomeViewModel.initHeight(topicContentArray, index: indexPath.row)
            return contentHeight + 40
        }else {
            return 77
        }
    }
}
extension HomeViewController: WCSessionDelegate {
    
}