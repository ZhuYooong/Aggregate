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
    static let shareAllNodeViewModel = AllNodeViewModel()
    private override init() {}
    //MARK: - 网络请求
    func findAllNode(initData: (contentArray: [Node]?)->Void) {//取所有节点
        NetDataManager.shareNetDataManager.findAllNode(){
            (data) in
            var allNodes = [Node]()
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
                    let allNode = Node(id: subJson["id"].stringValue, name: subJson["name"].stringValue, url: subJson["url"].stringValue, title: subJson["title"].stringValue, title_alternative: subJson["title_alternative"].stringValue, topics: subJson["topics"].stringValue, header: subJson["header"].stringValue, footer: subJson["footer"].stringValue, created: subJson["created"].stringValue)
                    allNodes.append(allNode)
                }
            }
            initData(contentArray: allNodes)
        }
    }
    //MARK: - 数据逻辑
    func findMineNode(mineNode: ([Node]) -> Void) {//我的节点
        let fetchRequest = NSFetchRequest(entityName: "NodeInfo")
        do {
            let fetchResults = try context.executeFetchRequest(fetchRequest) as? [NodeInfo]
            if let fetchResults = fetchResults {
                var mineNodes = [Node]()
                for nodeItem in fetchResults {
                    let node = Node(id: nodeItem.id, name: nodeItem.name, url: nodeItem.url, title: nodeItem.title, title_alternative: nodeItem.title_alternative, topics: nodeItem.topics, header: nodeItem.header, footer: nodeItem.footer, created: nodeItem.created)
                    mineNodes.append(node)
                }
                mineNode(mineNodes)
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
                        context.deleteObject(mineNode)
                        try context.save()
                    }
                }
            } catch let error1 as NSError {
                print(error1)
            }
        }
    }
    func insertMineNode(insertNode: Node?) {//插入我的节点
        if let insertNode = insertNode, id = insertNode.id {
            let fetchRequest = NSFetchRequest(entityName: "NodeInfo")
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            do {
                let fetchResults = try context.executeFetchRequest(fetchRequest) as? [NodeInfo]
                if let fetchResults = fetchResults where fetchResults.count > 0 {
                    return
                }else {
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
                    try context.save()
                }
            } catch let error1 as NSError {
                print(error1)
            }
        }
    }
}
