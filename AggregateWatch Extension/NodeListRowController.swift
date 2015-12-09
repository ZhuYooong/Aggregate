//
//  NodeListRowController.swift
//  Aggregate
//
//  Created by MAC on 15/12/2.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import WatchKit

class NodeListRowController: NSObject {
    @IBOutlet var NodeTitleLable: WKInterfaceLabel!
    var nodeContent: Node? {
        didSet {
            if let nodeContent = nodeContent {
                NodeTitleLable.setText(nodeContent.title)
            }
        }
    }
}
