//
//  AllNodeViewController.swift
//  Aggregate
//
//  Created by 朱勇 on 15/10/14.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
import PKHUD
typealias findTopicfunc = ([TopicInfo], String) ->Void
class AllNodeViewController: UIViewController {
    @IBOutlet weak var scrollViewHeaderHeight: NSLayoutConstraint!
    @IBOutlet weak var selectNodeView: NodeListView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var allNodeScrollView: UIScrollView!
    var allNodeView: NodeListView?
    var allNodeContentArray = [NodeInfo]()
    var didselectItem = findTopicfunc?()//返回节点内容
    var selectNodeContentArray = [NodeInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initItem()
        initData()
    }
    func initItem() {//初始化控件
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "编辑", style: UIBarButtonItemStyle.Done, target: self, action: "compileButtonClick:")
    }
    func compileButtonClick(sender: UIBarButtonItem) {
        if sender.title == "编辑" {
            sender.title = "确定"
            allNodeView?.canCompiled = true
        }else if sender.title == "确定" {
            
            navigationController?.popViewControllerAnimated(true)
        }
    }
    func initData() {//初始化数据
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        AllNodeViewModel.shareAllNodeViewModel().findAllNode() {
            (contentArray: [NodeInfo]?) in
            self.creatNodeView(contentArray)
        }
    }
    func creatNodeView(allNodeArray: [NodeInfo]?) {
        allNodeView = NodeListView()
        allNodeView?.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, allNodeScrollView.frame.size.height)
        allNodeView?.setTagWithTagArray(allNodeArray, theBackgroundColor: nil, signalTagColor: UIColor.whiteColor(), canTouch: true)
        allNodeView?.didselectItem = {
            (array: [NodeInfo]?, allNodeArray: [TopicInfo]?, tittleStr: String?) in
            if let array = array where self.allNodeView?.canCompiled == true {
                self.selectNodeView.setTagWithTagArray(array, theBackgroundColor: nil, signalTagColor: UIColor.whiteColor(), canTouch: false)
                UIView.animateWithDuration(0.1) {
                    () in
                    self.scrollViewHeaderHeight.constant = self.selectNodeView.frame.size.height + 37
                    self.view.layoutIfNeeded()
                }
            }
            if let allNodeArray = allNodeArray where self.allNodeView?.canCompiled == false, let tittleStr = tittleStr {
                self.didselectItem!(allNodeArray, tittleStr)
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        self.allNodeScrollView.addSubview(self.allNodeView!)
        self.allNodeScrollView.contentSize = self.allNodeView!.frame.size
    }
}
