//
//  HomeViewModel.swift
//  Aggregate
//
//  Created by MAC on 15/10/22.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData
class HomeViewModel: NSObject {
    var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext //获取存储的上下文
    static let homeViewModel: HomeViewModel = HomeViewModel()
    static func shareHomeViewModel() -> HomeViewModel {
        return homeViewModel
    }
    //MARK:-网络请求
    func findHotTopics()->[TopicInfo] {//取热议主题
        var hotTopics = [TopicInfo]()
        NetDataManager.shareNetDataManager().findHotTopics(){
            (data) in
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
                    let topic = NSEntityDescription.insertNewObjectForEntityForName("TopicInfo", inManagedObjectContext: self.context) as! TopicInfo
                    topic.id = subJson["id"].string
                    topic.title = subJson["title"].string
                    topic.url = subJson["url"].string
                    topic.content = subJson["content"].string
                    topic.content_rendered = subJson["content_rendered"].string
                    topic.replies = subJson["replies"].string
                    topic.member_id = subJson["member"]["id"].string
                    topic.member_username = subJson["member"]["username"].string
                    topic.member_tagline = subJson["member"]["tagline"].string
                    topic.member_avatar_mini = subJson["member"]["avatar_mini"].string
                    topic.member_avatar_normal = subJson["member"]["avatar_normal"].string
                    topic.member_avatar_large = subJson["member"]["avatar_large"].string
                    topic.node_id = subJson["node"]["id"].string
                    topic.node_topics = subJson["node"]["topics"].string
                    topic.node_avatar_mini = subJson["node"]["avatar_mini"].string
                    topic.node_avatar_normal = subJson["node"]["avatar_normal"].string
                    topic.node_avatar_large = subJson["node"]["avatar_large"].string
                    topic.node_title = subJson["node"]["title"].string
                    topic.node_name = subJson["node"]["name"].string
                    topic.node_url = subJson["node"]["url"].string
                    topic.created = subJson["created"].string
                    topic.last_modified = subJson["last_modified"].string
                    topic.last_touched = subJson["last_touched"].string
                    hotTopics.append(topic)
                }
            }
        }
        return hotTopics
    }
}
