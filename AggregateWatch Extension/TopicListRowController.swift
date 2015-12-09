//
//  TopicListRowController.swift
//  Aggregate
//
//  Created by MAC on 15/12/2.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import WatchKit

class TopicListRowController: NSObject {
    @IBOutlet var topicTitleLable: WKInterfaceLabel!
    var topicContent: Topic? {
        didSet {
            if let topicContent = topicContent {
                topicTitleLable.setText(topicContent.title)
            }
        }
    }
}
