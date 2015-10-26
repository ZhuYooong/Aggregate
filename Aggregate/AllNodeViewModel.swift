//
//  AllNodeViewModel.swift
//  Aggregate
//
//  Created by MAC on 15/10/26.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData
class AllNodeViewModel: NSObject {
    var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext //获取存储的上下文
    static let allNodeViewModel: AllNodeViewModel = AllNodeViewModel()
    static func shareAllNodeViewModel() -> AllNodeViewModel {
        return allNodeViewModel
    }
    //MARK:-网络请求
    func findAllNode(initData: (contentArray: [NodeInfo]?)->Void) {//取所有节点
        NetDataManager.shareNetDataManager().findAllNode(){
            (data) in
            var allNodes = [NodeInfo]()
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
                    let allNode = NSEntityDescription.insertNewObjectForEntityForName("NodeInfo", inManagedObjectContext: self.context) as! NodeInfo
                    allNode.id = subJson["id"].stringValue
                    allNode.name = subJson["name"].stringValue
                    allNode.url = subJson["url"].stringValue
                    allNode.title = subJson["title"].stringValue
                    allNode.title_alternative = subJson["title_alternative"].stringValue
                    allNode.topics = subJson["topics"].stringValue
                    allNode.header = subJson["header"].stringValue
                    allNode.footer = subJson["footer"].stringValue
                    allNode.created = subJson["created"].stringValue
                    allNodes.append(allNode)
                }
            }
            initData(contentArray: allNodes)
        }
    }
}
