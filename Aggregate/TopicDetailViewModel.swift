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
    func findTopicsInfo(topicId: String, initData: (contentArray: Topic?)->Void) {//取主题信息
        NetDataManager.shareNetDataManager().findTopicsInfo(topicId) {
            (data) in
            if let data = data {
                let json = JSON(data: data)
                if json.arrayValue.count > 0 {
                    let subJson = json.arrayValue[0]
                    let topic = Topic(id: subJson["id"].stringValue, title: subJson["title"].stringValue, url: subJson["url"].stringValue, content: subJson["content"].stringValue, content_rendered: subJson["content_rendered"].stringValue, replies: subJson["replies"].stringValue, member_id: subJson["member"]["id"].stringValue, node_id: subJson["node"]["id"].stringValue, created: subJson["created"].stringValue, last_modified: subJson["last_modified"].stringValue, last_touched: subJson["last_touched"].stringValue, member_username: subJson["member"]["username"].stringValue, member_tagline: subJson["member"]["tagline"].stringValue, member_avatar_mini: subJson["member"]["avatar_mini"].stringValue, member_avatar_normal: subJson["member"]["avatar_normal"].stringValue, member_avatar_large: subJson["member"]["avatar_large"].stringValue, node_name: subJson["node"]["name"].stringValue, node_title: subJson["node"]["title"].stringValue, node_url: subJson["node"]["url"].stringValue, node_topics: subJson["node"]["topics"].stringValue, node_avatar_mini: subJson["node"]["avatar_mini"].stringValue, node_avatar_normal: subJson["node"]["avatar_normal"].stringValue, node_avatar_large: subJson["node"]["avatar_large"].stringValue)
                    initData(contentArray: topic)
                }
            }
        }
    }
    func findReplies(topicId: String, page: String?, initData: (contentArray: [Replies]?)->Void) {//取主题回复
        NetDataManager.shareNetDataManager().findReplies(topicId, page: page) {
            (data) in
            var replies = [Replies]()
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
                    let reply = Replies(id: subJson["id"].stringValue, thanks: subJson["thanks"].stringValue, content: subJson["content"].stringValue, content_rendered: subJson["content_rendered"].stringValue, member_id: subJson["member"]["id"].stringValue, member_username: subJson["member"]["username"].stringValue, member_tagline: subJson["member"]["tagline"].stringValue, member_avatar_mini: subJson["member"]["avatar_mini"].stringValue, member_avatar_normal: subJson["member"]["avatar_normal"].stringValue, member_avatar_large: subJson["member"]["avatar_large"].stringValue, created: subJson["created"].stringValue, last_modified: subJson["last_modified"].stringValue)
                    replies.append(reply)
                }
            }
            initData(contentArray: replies)
        }
    }
}
