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
        //清空列表
        let range = NSMakeRange(0, topicListArray.count)
        let set = NSIndexSet(indexesInRange: range)
        TopicListTable.removeRowsAtIndexes(set)
        //给列表重新赋值
        for i in 0 ..< topicListArray.count {
            TopicListTable.insertRowsAtIndexes(NSIndexSet(index: i), withRowType: "TopicList")
            let topicListRowController = TopicListTable.rowControllerAtIndex(i) as? TopicListRowController
            topicListRowController?.goToContentButton.setTitle(topicListArray[i].title)
            topicListRowController?.goToContrntFunc = {
                let nodeModels = NSArray(objects: self.topicListArray[i])
                self.pushControllerWithName("TopicContent", context: nodeModels)
            }
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
