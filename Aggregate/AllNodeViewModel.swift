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
    func findAllNode(view: UIView, initData: (contentArray: [NodeInfo]?)->Void) {//取所有节点
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
    //MARK:-数据逻辑
    func findMineNode(mineNode: ([NodeInfo]) -> Void) {//我的节点
        let fetchRequest = NSFetchRequest(entityName: "TopicInfo")
        do {
            let fetchResults = try context.executeFetchRequest(fetchRequest) as? [NodeInfo]
            if let fetchResults = fetchResults where fetchResults.count > 0 {
                mineNode(fetchResults)
            }
        } catch let error1 as NSError {
            print(error1)
        }
    }
}
