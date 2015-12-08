//
//  NodeListView.swift
//  Aggregate
//
//  Created by 朱勇 on 15/10/15.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
import CoreData
import PKHUD
typealias callbackfunc = ([Node]?, [Topic]?, String?) ->Void
class NodeListView: UIView {
    var totalHeight: Float = 0
    var previousFrame: CGRect?
    var tagArray = [Node]?()
    var canCompiled = false //是否需要编辑
    var didselectItem = callbackfunc?()//回调统计选中tag
    func setTagWithTagArray(array: [Node]?, theBackgroundColor: UIColor?, signalTagColor: UIColor?, canTouch: Bool){
        previousFrame = CGRectZero
        totalHeight = 0
        if let array = array {
            tagArray = [Node](array)
            for view in self.subviews {
                view.removeFromSuperview()
            }
            for (index,value) in array.enumerate(){
                let tagBtn = UIButton(type: UIButtonType.Custom)
                tagBtn.frame = CGRectZero
                if let signalTagColor = signalTagColor {//可以单一设置tag的颜色
                    tagBtn.backgroundColor = signalTagColor
                }else { //tag颜色多样
                    tagBtn.backgroundColor = UIColor(red: CGFloat(random()%255/255), green: CGFloat(random()%255/255), blue: CGFloat(random()%255/255), alpha: 1)
                }
                tagBtn.userInteractionEnabled = canTouch//回调统计选中tag
                tagBtn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
                tagBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
                tagBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
                tagBtn.addTarget(self, action: "tagBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
                tagBtn.setTitle(value.title, forState: UIControlState.Normal)
                tagBtn.tag = 1000 + index
                tagBtn.layer.cornerRadius = 13
                tagBtn.layer.borderColor = UIColor.darkGrayColor().CGColor
                tagBtn.layer.borderWidth = 0.3
                tagBtn.clipsToBounds = true
                if let tittle = value.title {
                    let stringSize = tittle.boundingRectWithSize(CGSizeMake(2000, 40), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15)], context: nil)
                    let newWidth = stringSize.width + 7 * 3
                    let newHeight = stringSize.height + 3 * 3
                    var newRect = CGRectZero
                    if let previousFrameX = previousFrame?.origin.x, previousFrameWidth = previousFrame?.size.width where previousFrameX + previousFrameWidth + newWidth + 10 > UIScreen.mainScreen().bounds.width {
                        newRect.origin = CGPointMake(10, previousFrame!.origin.y + newHeight + 10)
                        totalHeight += Float(newHeight) + 10
                    }else {
                        newRect.origin = CGPointMake(previousFrame!.origin.x + previousFrame!.size.width + 10, previousFrame!.origin.y)
                    }
                    newRect.size = CGSizeMake(newWidth, newHeight)
                    tagBtn.frame = newRect
                    previousFrame = tagBtn.frame
                    setViewHeight(self, andHeight: CGFloat(totalHeight) + newHeight + 4)
                    self.addSubview(tagBtn)
                }
            }
        }
        if let theBackgroundColor = theBackgroundColor {//整个view的背景色
            self.backgroundColor = theBackgroundColor
        }else {
            self.backgroundColor = UIColor.whiteColor()
        }
    }
    func setViewHeight(view: UIView, andHeight hight:CGFloat) {//改变节点高度
        var tempFrame = view.frame
        tempFrame.size.height = hight
        view.frame = tempFrame
    }
    //MARK:- 节点点击事件
    func editMineNode() {//显示自己的节点
        AllNodeViewModel.shareAllNodeViewModel.findMineNode() {
            (mineNodeContentArr) in
            for mineNode in mineNodeContentArr {
                for view in self.subviews {
                    if let temBtn: UIButton = (view as? UIButton) where temBtn.selected == false {
                        if let id = self.tagArray?[temBtn.tag - 1000].id where id == mineNode.id {
                            self.tagBtnClick(temBtn)
                        }
                    }
                }
            }
        }
    }
    func tagBtnClick(sender: UIButton) {//node点击事件
        if canCompiled == true {//编辑节点
            sender.selected = !sender.selected
            if sender.selected == true {//插入
                if let mineNode = tagArray?[sender.tag - 1000] {
                    AllNodeViewModel.shareAllNodeViewModel.insertMineNode(mineNode)
                    sender.backgroundColor = UIColor.orangeColor()
                }
            }else if sender.selected == false {//删除
                if let id = tagArray?[sender.tag - 1000].id {
                    AllNodeViewModel.shareAllNodeViewModel.removeMineNode(id)
                    sender.backgroundColor = UIColor.whiteColor()
                }
            }
            didSelectItems()
        }else {
            if let id = tagArray?[sender.tag - 1000].id {
                PKHUD.sharedHUD.contentView = PKHUDProgressView()
                PKHUD.sharedHUD.show()
                HomeViewModel.shareHomeViewModel.findNodeTopics(nil, nodeId: id, nodeName: nil, initData: {
                    (contentArray: [Topic]?) in
                    self.didselectItem!(nil, contentArray, sender.titleLabel?.text)
                })
            }
        }
    }
    func didSelectItems() {
        var temArray = [Node]()
        for view in self.subviews {
            if let temBtn: UIButton = (view as? UIButton) where temBtn.selected == true {
                if let temStr = tagArray?[temBtn.tag - 1000] {
                  temArray.append(temStr)
                }
            }
        }
        didselectItem!(temArray, nil, nil)
    }
}
