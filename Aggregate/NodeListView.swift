//
//  NodeListView.swift
//  Aggregate
//
//  Created by 朱勇 on 15/10/15.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
typealias callbackfunc = ([String]) ->Void
class NodeListView: UIView {
    var totalHeight: Float = 0
    var previousFrame: CGRect?
    var tagArray = [String]?()
    var didselectItem = callbackfunc?()//回调统计选中tag
    func setTagWithTagArray(array: [String]?, theBackgroundColor: UIColor?, signalTagColor: UIColor?, canTouch: Bool){
        previousFrame = CGRectZero
        totalHeight = 0
        if let array = array {
            tagArray = [String](array)
            for view in self.subviews {
                view.removeFromSuperview()
            }
            for (index,value) in array.enumerate(){
                let tagBtn = UIButton(type: UIButtonType.Custom)
                tagBtn.frame=CGRectZero
                if let signalTagColor = signalTagColor {//可以单一设置tag的颜色
                    tagBtn.backgroundColor = signalTagColor
                }else { //tag颜色多样
                    tagBtn.backgroundColor = UIColor(red: CGFloat(random()%255/255), green: CGFloat(random()%255/255), blue: CGFloat(random()%255/255), alpha: 1)
                }
                tagBtn.userInteractionEnabled=canTouch//回调统计选中tag
                tagBtn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
                tagBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
                tagBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
                tagBtn.addTarget(self, action: "tagBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
                tagBtn.setTitle(value, forState: UIControlState.Normal)
                tagBtn.tag = 1000 + index
                tagBtn.layer.cornerRadius = 13
                tagBtn.layer.borderColor = UIColor.darkGrayColor().CGColor
                tagBtn.layer.borderWidth = 0.3
                tagBtn.clipsToBounds = true
                let stringSize = value.boundingRectWithSize(CGSizeMake(2000, 40), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15)], context: nil)
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
                setViewHeight(self, andHeight: CGFloat(totalHeight) + newHeight + 10)
                self.addSubview(tagBtn)
            }
        }
        if let theBackgroundColor = theBackgroundColor {//整个view的背景色
            self.backgroundColor = theBackgroundColor
        }else {
            self.backgroundColor = UIColor.whiteColor()
        }
    }
    //MARK:- 改变控件高度
    func setViewHeight(view: UIView, andHeight hight:CGFloat) {
        var tempFrame = view.frame
        tempFrame.size.height = hight
        view.frame = tempFrame
    }
    func tagBtnClick(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected == true {
            sender.backgroundColor = UIColor.orangeColor()
        }else if sender.selected == false {
            sender.backgroundColor = UIColor.whiteColor()
        }
        didSelectItems()
    }
    func didSelectItems() {
        var temArray = [String]()
        for view in self.subviews {
            if let temBtn: UIButton = (view as? UIButton) where temBtn.selected == true {
                if let temStr = tagArray?[temBtn.tag - 1000] {
                  temArray.append(temStr)
                }
            }
        }
        didselectItem!(temArray)
    }
}
