//
//  TopicContentInterfaceController.swift
//  Aggregate
//
//  Created by MAC on 15/12/2.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import WatchKit
import Foundation

class TopicContentInterfaceController: WKInterfaceController {
    @IBOutlet var ContentListTable: WKInterfaceTable!
    var topicContentArray = [Replies]()
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let contentArray = context as? NSArray {
            if let topicContent = contentArray[0] as? Topic {
                initData(topicContent)
            }
        }
    }
    func initData(topicContent: Topic) {
        guard let idStr = topicContent.id else {
            return
        }
        setTitle(topicContent.title)
        TopicDetailViewModel.shareTopicDetailViewModel.findReplies(idStr, page: "\(0)") {
            (contentArray) in
            if let contentArray = contentArray where contentArray.count > 0 {
                self.reloadData(topicContent, contentArray: contentArray)
            }
        }
    }
    func reloadData(topicContent: Topic, contentArray: [Replies]) {//刷新列表
        //清空列表
        let range = NSMakeRange(0, contentArray.count + 1)
        let set = NSIndexSet(indexesInRange: range)
        ContentListTable.removeRowsAtIndexes(set)
        //给列表重新赋值
        for i in 0 ..< contentArray.count + 1 {
            initItem(i, topicContent: topicContent, contentArray: contentArray)
        }
    }
    func initItem(index: Int, topicContent: Topic, contentArray: [Replies]) {
        ContentListTable.insertRowsAtIndexes(NSIndexSet(index: index), withRowType: "TopicContent")
        let topicContentRowController = ContentListTable.rowControllerAtIndex(index) as? TopicContentRowController
        if index == 0 {
            topicContentRowController?.topicContentLable.setText(topicContent.content)
        }else {
            topicContentRowController?.topicContentLable.setText(contentArray[index - 1].content)
        }
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
