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
    func findHotTopics(initData: (contentArray: [TopicInfo]?)->Void) {//取热议主题
        NetDataManager.shareNetDataManager().findHotTopics(){
            (data) in
            var hotTopics = [TopicInfo]()
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
                    let topic = NSEntityDescription.insertNewObjectForEntityForName("TopicInfo", inManagedObjectContext: self.context) as! TopicInfo
                    topic.id = subJson["id"].stringValue
                    topic.title = subJson["title"].stringValue
                    topic.url = subJson["url"].stringValue
                    topic.content = subJson["content"].stringValue
                    topic.content_rendered = subJson["content_rendered"].stringValue
                    topic.replies = subJson["replies"].stringValue
                    topic.member_id = subJson["member"]["id"].stringValue
                    topic.member_username = subJson["member"]["username"].stringValue
                    topic.member_tagline = subJson["member"]["tagline"].stringValue
                    topic.member_avatar_mini = subJson["member"]["avatar_mini"].stringValue
                    topic.member_avatar_normal = subJson["member"]["avatar_normal"].stringValue
                    topic.member_avatar_large = subJson["member"]["avatar_large"].stringValue
                    topic.node_id = subJson["node"]["id"].stringValue
                    topic.node_topics = subJson["node"]["topics"].stringValue
                    topic.node_avatar_mini = subJson["node"]["avatar_mini"].stringValue
                    topic.node_avatar_normal = subJson["node"]["avatar_normal"].stringValue
                    topic.node_avatar_large = subJson["node"]["avatar_large"].stringValue
                    topic.node_title = subJson["node"]["title"].stringValue
                    topic.node_name = subJson["node"]["name"].stringValue
                    topic.node_url = subJson["node"]["url"].stringValue
                    topic.created = subJson["created"].stringValue
                    topic.last_modified = subJson["last_modified"].stringValue
                    topic.last_touched = subJson["last_touched"].stringValue
                    hotTopics.append(topic)
                }
            }
            initData(contentArray: hotTopics)
        }
    }
    func findLastestTopics(initData: (contentArray: [TopicInfo]?)->Void) {//取全部主题
        NetDataManager.shareNetDataManager().findLatestTopics(){
            (data) in
            var allTopics = [TopicInfo]()
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
                    let topic = NSEntityDescription.insertNewObjectForEntityForName("TopicInfo", inManagedObjectContext: self.context) as! TopicInfo
                    topic.id = subJson["id"].stringValue
                    topic.title = subJson["title"].stringValue
                    topic.url = subJson["url"].stringValue
                    topic.content = subJson["content"].stringValue
                    topic.content_rendered = subJson["content_rendered"].stringValue
                    topic.replies = subJson["replies"].stringValue
                    topic.member_id = subJson["member"]["id"].stringValue
                    topic.member_username = subJson["member"]["username"].stringValue
                    topic.member_tagline = subJson["member"]["tagline"].stringValue
                    topic.member_avatar_mini = subJson["member"]["avatar_mini"].stringValue
                    topic.member_avatar_normal = subJson["member"]["avatar_normal"].stringValue
                    topic.member_avatar_large = subJson["member"]["avatar_large"].stringValue
                    topic.node_id = subJson["node"]["id"].stringValue
                    topic.node_topics = subJson["node"]["topics"].stringValue
                    topic.node_avatar_mini = subJson["node"]["avatar_mini"].stringValue
                    topic.node_avatar_normal = subJson["node"]["avatar_normal"].stringValue
                    topic.node_avatar_large = subJson["node"]["avatar_large"].stringValue
                    topic.node_title = subJson["node"]["title"].stringValue
                    topic.node_name = subJson["node"]["name"].stringValue
                    topic.node_url = subJson["node"]["url"].stringValue
                    topic.created = subJson["created"].stringValue
                    topic.last_modified = subJson["last_modified"].stringValue
                    topic.last_touched = subJson["last_touched"].stringValue
                    allTopics.append(topic)
                }
            }
            initData(contentArray: allTopics)
        }
    }
    func findNodeTopics(username: String?, nodeId: String?, nodeName: String?, initData: (contentArray: [TopicInfo]?)->Void) {//根据提供信息取主题
        NetDataManager.shareNetDataManager().findTopics(username, nodeId: nodeId, nodeName: nodeName){
            (data) in
            var thisTopics = [TopicInfo]()
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
                    let topic = NSEntityDescription.insertNewObjectForEntityForName("TopicInfo", inManagedObjectContext: self.context) as! TopicInfo
                    topic.id = subJson["id"].stringValue
                    topic.title = subJson["title"].stringValue
                    topic.url = subJson["url"].stringValue
                    topic.content = subJson["content"].stringValue
                    topic.content_rendered = subJson["content_rendered"].stringValue
                    topic.replies = subJson["replies"].stringValue
                    topic.member_id = subJson["member"]["id"].stringValue
                    topic.member_username = subJson["member"]["username"].stringValue
                    topic.member_tagline = subJson["member"]["tagline"].stringValue
                    topic.member_avatar_mini = subJson["member"]["avatar_mini"].stringValue
                    topic.member_avatar_normal = subJson["member"]["avatar_normal"].stringValue
                    topic.member_avatar_large = subJson["member"]["avatar_large"].stringValue
                    topic.node_id = subJson["node"]["id"].stringValue
                    topic.node_topics = subJson["node"]["topics"].stringValue
                    topic.node_avatar_mini = subJson["node"]["avatar_mini"].stringValue
                    topic.node_avatar_normal = subJson["node"]["avatar_normal"].stringValue
                    topic.node_avatar_large = subJson["node"]["avatar_large"].stringValue
                    topic.node_title = subJson["node"]["title"].stringValue
                    topic.node_name = subJson["node"]["name"].stringValue
                    topic.node_url = subJson["node"]["url"].stringValue
                    topic.created = subJson["created"].stringValue
                    topic.last_modified = subJson["last_modified"].stringValue
                    topic.last_touched = subJson["last_touched"].stringValue
                    thisTopics.append(topic)
                }
            }
            initData(contentArray: thisTopics)
        }
    }
    //MARK:-数据逻辑
    func initHeight(contentArray: [TopicInfo], index: Int) -> CGFloat {//cell高度
        var height: CGFloat = 36
        if let text = contentArray[index].title {
            let option = NSStringDrawingOptions.UsesLineFragmentOrigin
            let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(17)]
            height = text.boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 66, 10000), options: option, attributes: attributes, context: nil).size.height
        }
        return height + 2
    }
    func initDate(date: NSDate) -> String {//时间
        let dateFormatter = NSDateFormatter()
        let nowDate = NSDate()
        let time = nowDate.timeIntervalSinceDate(date)
        if time <= 60 {//一分钟以内
            return "刚刚"
        }else if time <= 60 * 60 {//一小时以内
            let mins = Int(time / 60)
            return "\(mins)分钟前"
        }else if time <= 60 * 60 * 24 {//两天以内
            dateFormatter.dateFormat = "YYYY/MM/dd"
            let need_yMd = dateFormatter.stringFromDate(date)
            let now_yMd = dateFormatter.stringFromDate(nowDate)
            dateFormatter.dateFormat = "HH:mm"
            if need_yMd == now_yMd {
                return "今天\(dateFormatter.stringFromDate(date))"
            }else {
                return "昨天\(dateFormatter.stringFromDate(date))"
            }
        }else {
            dateFormatter.dateFormat = "yyyy"
            let need_yMd = dateFormatter.stringFromDate(date)
            let now_yMd = dateFormatter.stringFromDate(nowDate)
            if need_yMd == now_yMd {//在同一年
                dateFormatter.dateFormat = "MM月dd日"
                return "\(dateFormatter.stringFromDate(date))"
            }else {
                dateFormatter.dateFormat = "yyyy/MM/dd"
                return "\(dateFormatter.stringFromDate(date))"
            }
        }
    }
    func initMineNode() -> [NodeInfo] {//最初我的节点
        let node1 = NSEntityDescription.insertNewObjectForEntityForName("NodeInfo", inManagedObjectContext: self.context) as! NodeInfo
        node1.title = "科技"
        node1.id = "445"
        let node2 = NSEntityDescription.insertNewObjectForEntityForName("NodeInfo", inManagedObjectContext: self.context) as! NodeInfo
        node2.title = "分享创造"
        node2.id = "17"
        let node3 = NSEntityDescription.insertNewObjectForEntityForName("NodeInfo", inManagedObjectContext: self.context) as! NodeInfo
        node3.title = "问与答"
        node3.id = "12"
        let node4 = NSEntityDescription.insertNewObjectForEntityForName("NodeInfo", inManagedObjectContext: self.context) as! NodeInfo
        node4.title = "apple"
        node4.id = "184"
        let node5 = NSEntityDescription.insertNewObjectForEntityForName("NodeInfo", inManagedObjectContext: self.context) as! NodeInfo
        node5.title = "酷工作"
        node5.id = "43"
        let node6 = NSEntityDescription.insertNewObjectForEntityForName("NodeInfo", inManagedObjectContext: self.context) as! NodeInfo
        node6.title = "优惠信息"
        node6.id = "747"
        let node7 = NSEntityDescription.insertNewObjectForEntityForName("NodeInfo", inManagedObjectContext: self.context) as! NodeInfo
        node7.title = "分享发现"
        node7.id = "16"
        let nodeArray = [node1, node2, node3, node4, node5, node6, node7]
        return nodeArray
    }
}
