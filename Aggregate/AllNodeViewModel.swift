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
    //MARK:-数据逻辑
    func findMineNode(mineNode: ([NodeInfo]) -> Void) {//我的节点
        let fetchRequest = NSFetchRequest(entityName: "NodeInfo")
        do {
            let fetchResults = try context.executeFetchRequest(fetchRequest) as? [NodeInfo]
            if let fetchResults = fetchResults where fetchResults.count > 0 {
                mineNode(fetchResults)
            }
        } catch let error1 as NSError {
            print(error1)
        }
    }
    func removeMineNode(id: String?) {//删除我的节点
        if let id = id {
            let fetchRequest = NSFetchRequest(entityName: "NodeInfo")
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            do {
                let fetchResults = try context.executeFetchRequest(fetchRequest) as? [NodeInfo]
                if let fetchResults = fetchResults where fetchResults.count > 0 {
                    for mineNode in fetchResults {
                        context.delete(mineNode)
                        try context.save()
                    }
                }
            } catch let error1 as NSError {
                print(error1)
            }
        }
    }
    func insertMineNode(insertNode: NodeInfo?) {//插入我的节点
        if let insertNode = insertNode {
            let entity = NSEntityDescription.insertNewObjectForEntityForName("NodeInfo", inManagedObjectContext: context) as! NodeInfo
            entity.id = insertNode.id
            entity.name = insertNode.name
            entity.url = insertNode.url
            entity.title = insertNode.title
            entity.title_alternative = insertNode.title_alternative
            entity.topics = insertNode.topics
            entity.header = insertNode.header
            entity.footer = insertNode.footer
            entity.created = insertNode.created
            do {
                try context.save()
            } catch let error1 as NSError {
                print(error1)
            }
        }
    }
}
