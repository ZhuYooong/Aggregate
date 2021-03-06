//
//  InterfaceController.swift
//  AggregateWatch Extension
//
//  Created by MAC on 15/12/1.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    @IBOutlet var NodeListTable: WKInterfaceTable!
    static var token: dispatch_once_t = 0
    static var session: WCSession?
    let userDefault = NSUserDefaults.standardUserDefaults()
    var mineNodeArray = [Node]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        initData()
    }
    //MARK:- 初始化数据
    func initData() {
        dispatch_once(&InterfaceController.token) { () -> Void in
            self.becomeActive()
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InterfaceController.becomeActive), name: applicationDidBecomeActiveNotification, object: nil)
            if WCSession.isSupported() {
                InterfaceController.session = WCSession.defaultSession()
                InterfaceController.session!.delegate = self
                InterfaceController.session!.activateSession()
            }
        }
    }
    func becomeActive() {
        mineNodeArray = [Node(id: "0", name: nil, url: nil, title: "今日热议", title_alternative: nil, topics: nil, header: nil, footer: nil, created: nil), Node(id: "1", name: nil, url: nil, title: "全部", title_alternative: nil, topics: nil, header: nil, footer: nil, created: nil)]
        if let contentArray = userDefault.objectForKey("MineNode") as? [Node] where contentArray.count > 0 {
            mineNodeArray += contentArray
        }else {
            mineNodeArray += HomeViewModel.shareHomeViewModel.initMineNode()
        }
        reloadData()
    }
    func reloadData() {//刷新列表
        NodeListTable.setNumberOfRows(mineNodeArray.count, withRowType: "NodeList")
        for i in 0 ..< mineNodeArray.count {
            if let nodeListRowController = NodeListTable.rowControllerAtIndex(i) as? NodeListRowController {
                nodeListRowController.nodeContent = mineNodeArray[i]
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
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        self.pushControllerWithName("TopicList", context: [self.mineNodeArray[rowIndex].self.id!, self.mineNodeArray[rowIndex].title!])
    }
}
extension InterfaceController: WCSessionDelegate {
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        guard let mineNodeArray = applicationContext["MineNode"] as? [Node] else {
            return
        }
        userDefault.setObject(mineNodeArray, forKey: "MineNode")
        userDefault.synchronize()
    }
}