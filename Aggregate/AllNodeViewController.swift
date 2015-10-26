//
//  AllNodeViewController.swift
//  Aggregate
//
//  Created by 朱勇 on 15/10/14.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class AllNodeViewController: UIViewController {
    @IBOutlet weak var scrollViewHeaderHeight: NSLayoutConstraint!
    @IBOutlet weak var selectNodeView: NodeListView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var allNodeScrollView: UIScrollView!
    var allNodeView: NodeListView?
    var allNodeContentArray = [NodeInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    func initData() {//初始化数据
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
            (array: [String]) in
            self.selectNodeView.setTagWithTagArray(allNodeArray, theBackgroundColor: nil, signalTagColor: UIColor.whiteColor(), canTouch: false)
            self.scrollViewHeaderHeight.constant = self.selectNodeView.frame.size.height + 37
            self.view.layoutIfNeeded()
        }
        self.allNodeScrollView.addSubview(self.allNodeView!)
        self.allNodeScrollView.contentSize = self.allNodeView!.frame.size
    }
}
