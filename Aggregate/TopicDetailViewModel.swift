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
    func findTopicsInfo(topicId: String, initData: (contentArray: [Topic]?)->Void) {//取主题信息
        NetDataManager.shareNetDataManager().findTopicsInfo(topicId) {
            (data) in
            var topicInfos = [Topic]()
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
//                    let topic = Topic(id: <#T##String?#>, title: <#T##String?#>, url: <#T##String?#>, content: <#T##String?#>, content_rendered: <#T##String?#>, replies: <#T##String?#>, member_id: <#T##String?#>, node_id: <#T##String?#>, created: <#T##String?#>, last_modified: <#T##String?#>, last_touched: <#T##String?#>, member_username: <#T##String?#>, member_tagline: <#T##String?#>, member_avatar_mini: <#T##String?#>, member_avatar_normal: <#T##String?#>, member_avatar_large: <#T##String?#>, node_name: <#T##String?#>, node_title: <#T##String?#>, node_url: <#T##String?#>, node_topics: <#T##String?#>, node_avatar_mini: <#T##String?#>, node_avatar_normal: <#T##String?#>, node_avatar_large: <#T##String?#>))
                    
//                    topicInfos.append(topic)
                }
            }
            initData(contentArray: topicInfos)
        }
    }
    func findReplies(topicId: String, page: String?, initData: (contentArray: [Replies]?)->Void) {//取主题回复
        NetDataManager.shareNetDataManager().findReplies(topicId, page: page) {
            (data) in
            var replies = [Replies]()
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
//                    let reply = Replies(id: <#T##String?#>, thanks: <#T##String?#>, content: <#T##String?#>, content_rendered: <#T##String?#>, member_id: <#T##String?#>, member_username: <#T##String?#>, member_tagline: <#T##String?#>, member_avatar_mini: <#T##String?#>, member_avatar_normal: <#T##String?#>, member_avatar_large: <#T##String?#>, created: <#T##String?#>, last_modified: <#T##String?#>)
//                    
//                    replies.append(reply)
                }
            }
            initData(contentArray: replies)
        }
    }
}
