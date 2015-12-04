//
//  NodeListRowController.swift
//  Aggregate
//
//  Created by MAC on 15/12/2.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import WatchKit
typealias skipFunc = () -> Void
class NodeListRowController: NSObject {
    var goToTopicFunc = skipFunc?()
    @IBOutlet var goToTopicButton: WKInterfaceButton!
    @IBAction func goToTopic() {
        goToTopicFunc!()
    }
}
