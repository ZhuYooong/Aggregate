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
    //MARK: - 网络请求
    func findHotTopics(initData: (contentArray: [Topic]?)->Void) {//取热议主题
        NetDataManager.shareNetDataManager().findHotTopics(){
            (data) in
            var hotTopics = [Topic]()
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
                    let topic = Topic(id: subJson["id"].stringValue, title: subJson["title"].stringValue, url: subJson["url"].stringValue, content: subJson["content"].stringValue, content_rendered: subJson["content_rendered"].stringValue, replies: subJson["replies"].stringValue, member_id: subJson["member"]["id"].stringValue, node_id: subJson["node"]["id"].stringValue, created: subJson["created"].stringValue, last_modified: subJson["last_modified"].stringValue, last_touched: subJson["last_touched"].stringValue, member_username: subJson["member"]["username"].stringValue, member_tagline: subJson["member"]["tagline"].stringValue, member_avatar_mini: subJson["member"]["avatar_mini"].stringValue, member_avatar_normal: subJson["member"]["avatar_normal"].stringValue, member_avatar_large: subJson["member"]["avatar_large"].stringValue, node_name: subJson["node"]["name"].stringValue, node_title: subJson["node"]["title"].stringValue, node_url: subJson["node"]["url"].stringValue, node_topics: subJson["node"]["topics"].stringValue, node_avatar_mini: subJson["node"]["avatar_mini"].stringValue, node_avatar_normal: subJson["node"]["avatar_normal"].stringValue, node_avatar_large: subJson["node"]["avatar_large"].stringValue)
                    hotTopics.append(topic)
                }
            }
            initData(contentArray: hotTopics)
        }
    }
    func findLastestTopics(initData: (contentArray: [Topic]?)->Void) {//取全部主题
        NetDataManager.shareNetDataManager().findLatestTopics(){
            (data) in
            var allTopics = [Topic]()
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
                    let topic = Topic(id: subJson["id"].stringValue, title: subJson["title"].stringValue, url: subJson["url"].stringValue, content: subJson["content"].stringValue, content_rendered: subJson["content_rendered"].stringValue, replies: subJson["replies"].stringValue, member_id: subJson["member"]["id"].stringValue, node_id: subJson["node"]["id"].stringValue, created: subJson["created"].stringValue, last_modified: subJson["last_modified"].stringValue, last_touched: subJson["last_touched"].stringValue, member_username: subJson["member"]["username"].stringValue, member_tagline: subJson["member"]["tagline"].stringValue, member_avatar_mini: subJson["member"]["avatar_mini"].stringValue, member_avatar_normal: subJson["member"]["avatar_normal"].stringValue, member_avatar_large: subJson["member"]["avatar_large"].stringValue, node_name: subJson["node"]["name"].stringValue, node_title: subJson["node"]["title"].stringValue, node_url: subJson["node"]["url"].stringValue, node_topics: subJson["node"]["topics"].stringValue, node_avatar_mini: subJson["node"]["avatar_mini"].stringValue, node_avatar_normal: subJson["node"]["avatar_normal"].stringValue, node_avatar_large: subJson["node"]["avatar_large"].stringValue)
                    allTopics.append(topic)
                }
            }
            initData(contentArray: allTopics)
        }
    }
    func findNodeTopics(username: String?, nodeId: String?, nodeName: String?, initData: (contentArray: [Topic]?)->Void) {//根据提供信息取主题
        NetDataManager.shareNetDataManager().findTopics(username, nodeId: nodeId, nodeName: nodeName){
            (data) in
            var thisTopics = [Topic]()
            if let data = data {
                let json = JSON(data: data)
                for subJson in json.arrayValue {
                    let topic = Topic(id: subJson["id"].stringValue, title: subJson["title"].stringValue, url: subJson["url"].stringValue, content: subJson["content"].stringValue, content_rendered: subJson["content_rendered"].stringValue, replies: subJson["replies"].stringValue, member_id: subJson["member"]["id"].stringValue, node_id: subJson["node"]["id"].stringValue, created: subJson["created"].stringValue, last_modified: subJson["last_modified"].stringValue, last_touched: subJson["last_touched"].stringValue, member_username: subJson["member"]["username"].stringValue, member_tagline: subJson["member"]["tagline"].stringValue, member_avatar_mini: subJson["member"]["avatar_mini"].stringValue, member_avatar_normal: subJson["member"]["avatar_normal"].stringValue, member_avatar_large: subJson["member"]["avatar_large"].stringValue, node_name: subJson["node"]["name"].stringValue, node_title: subJson["node"]["title"].stringValue, node_url: subJson["node"]["url"].stringValue, node_topics: subJson["node"]["topics"].stringValue, node_avatar_mini: subJson["node"]["avatar_mini"].stringValue, node_avatar_normal: subJson["node"]["avatar_normal"].stringValue, node_avatar_large: subJson["node"]["avatar_large"].stringValue)
                    thisTopics.append(topic)
                }
            }
            initData(contentArray: thisTopics)
        }
    }
    //MARK: - 数据逻辑
    func initHeight(contentArray: [Topic], index: Int) -> CGFloat {//cell高度
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
    func initMineNode() -> [Node] {//最初我的节点
        let node1 = Node(id: "445", name: nil, url: nil, title: "科技", title_alternative: nil, topics: nil, header: nil, footer: nil, created: nil)
        let node2 = Node(id: "17", name: nil, url: nil, title: "分享创造", title_alternative: nil, topics: nil, header: nil, footer: nil, created: nil)
        let node3 = Node(id: "12", name: nil, url: nil, title: "问与答", title_alternative: nil, topics: nil, header: nil, footer: nil, created: nil)
        let node4 = Node(id: "184", name: nil, url: nil, title: "apple", title_alternative: nil, topics: nil, header: nil, footer: nil, created: nil)
        let node5 = Node(id: "43", name: nil, url: nil, title: "酷工作", title_alternative: nil, topics: nil, header: nil, footer: nil, created: nil)
        let node6 = Node(id: "747", name: nil, url: nil, title: "优惠信息", title_alternative: nil, topics: nil, header: nil, footer: nil, created: nil)
        let node7 = Node(id: "16", name: nil, url: nil, title: "分享发现", title_alternative: nil, topics: nil, header: nil, footer: nil, created: nil)
        let nodeArray = [node1, node2, node3, node4, node5, node6, node7]
        return nodeArray
    }
}
