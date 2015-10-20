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
    override func viewDidLoad() {
        super.viewDidLoad()
        creatNodeView()
    }
    func creatNodeView() {
        let strArray=["大好人","自定义流式标签","github","code4app","已婚","阳光开朗","慷慨大方帅气身材好","仗义","值得一交的朋友","值得一交的朋友","值得的交","值得一交的朋友","值得一交的朋友","大好人","自定义流式标签","github","code4app","已婚"];
        allNodeView = NodeListView()
        allNodeView?.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, allNodeScrollView.frame.size.height)
        allNodeView?.setTagWithTagArray(strArray, theBackgroundColor: nil, signalTagColor: UIColor.whiteColor(), canTouch: true)
        allNodeView?.didselectItem = {
            (array: [String]) in
            self.selectNodeView.setTagWithTagArray(array, theBackgroundColor: nil, signalTagColor: UIColor.whiteColor(), canTouch: false)
            self.scrollViewHeaderHeight.constant = self.selectNodeView.frame.size.height + 37
            self.view.layoutIfNeeded()
        }
        allNodeScrollView.addSubview(allNodeView!)
        allNodeScrollView.contentSize = allNodeView!.frame.size
    }
}
