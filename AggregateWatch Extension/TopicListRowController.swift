//
//  TopicListRowController.swift
//  Aggregate
//
//  Created by MAC on 15/12/2.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import WatchKit

class TopicListRowController: NSObject {
    var goToContrntFunc = skipFunc?()
    @IBOutlet var goToContentButton: WKInterfaceButton!
    @IBAction func goToContrnt() {
        goToContrntFunc!()
    }
}
