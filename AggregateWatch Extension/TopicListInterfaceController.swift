//
//  TopicListInterfaceController.swift
//  Aggregate
//
//  Created by MAC on 15/12/2.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import WatchKit
import Foundation

class TopicListInterfaceController: WKInterfaceController {
    @IBOutlet var TopicListTable: WKInterfaceTable!
    var topicListArray = [Topic]()
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let contentArray = context as? NSArray {
            if let id = contentArray[0] as? String, let title = contentArray[1] as? String {
                initData(id, titleStr: title)
            }
        }
    }
    func initData(idStr: String, titleStr: String) {
        setTitle(titleStr)
        switch idStr {
        case "0" :
            HomeViewModel.shareHomeViewModel.findHotTopics() {
                (contentArray: [Topic]?) in
                self.becomeActive(contentArray)
            }
        case "1":
            HomeViewModel.shareHomeViewModel.findLastestTopics() {
                (contentArray: [Topic]?) in
                self.becomeActive(contentArray)
            }
        default:
            HomeViewModel.shareHomeViewModel.findNodeTopics(nil, nodeId: idStr, nodeName: nil, initData: {
                (contentArray: [Topic]?) in
                self.becomeActive(contentArray)
            })
        }
    }
    func becomeActive(contentArray: [Topic]?) {
        guard let contentArray = contentArray else {
            return
        }
        topicListArray = contentArray
        reloadData()
    }
    func reloadData() {//刷新列表
        TopicListTable.setNumberOfRows(topicListArray.count, withRowType: "TopicList")
        for i in 0 ..< topicListArray.count {
            let topicListRowController = TopicListTable.rowControllerAtIndex(i) as? TopicListRowController
            topicListRowController?.topicContent = topicListArray[i]
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
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        self.pushControllerWithName("TopicContent", context: [self.topicListArray[rowIndex]])
    }
}
