//
//  TopicDetailViewModel.swift
//  Aggregate
//
//  Created by MAC on 15/10/30.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData
class TopicDetailViewModel: NSObject {
    var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext //获取存储的上下文
    static let topicDetailViewModel: TopicDetailViewModel = TopicDetailViewModel()
    static func shareTopicDetailViewModel() -> TopicDetailViewModel {
        return topicDetailViewModel
    }
    //MARK:-网络请求
    func findTopicsInfo(topicId: String, initData: (contentArray: [TopicInfo]?)->Void) {//取主题信息
        NetDataManager.shareNetDataManager().findTopicsInfo(topicId) {
            (data) in
            var topicInfos = [TopicInfo]()
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
                    let topic = NSEntityDescription.insertNewObjectForEntityForName("TopicInfo", inManagedObjectContext: self.context) as! TopicInfo
                    
                    topicInfos.append(topic)
                }
            }
            initData(contentArray: topicInfos)
        }
    }
    func findReplies(topicId: String, page: String?, initData: (contentArray: [RepliesInfo]?)->Void) {//取主题回复
        NetDataManager.shareNetDataManager().findReplies(topicId, page: page) {
            (data) in
            var replies = [RepliesInfo]()
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
                    let reply = NSEntityDescription.insertNewObjectForEntityForName("RepliesInfo", inManagedObjectContext: self.context) as! RepliesInfo
                    
                    replies.append(reply)
                }
            }
            initData(contentArray: replies)
        }
    }
}
