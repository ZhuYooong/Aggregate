//
//  NetDataManager.swift
//  Aggregate
//
//  Created by 朱勇 on 15/10/12.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class NetDataManager: NSObject {
    static let shareNetDataManager = NetDataManager()
    private override init() { }
    let pageSize = 20
    //baseURL
    let V2EXBaseURL = "https://www.v2ex.com/api"
    //get方法
    func GETRequest(URLString: String, NetData: (data: NSData?)->Void) {
        guard let url = NSURL(string: URLString) else {
            return
        }
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if error == nil {
                NetData(data: data)
            }
        }
        task.resume()
    }
}
//MARK:- V2EX
extension NetDataManager {
    //取网站信息
    func findWebInfo(NetData: (data: NSData?)->Void) {
        GETRequest("\(V2EXBaseURL)/site/info.json", NetData: NetData)
    }
    //取所有节点
    func findAllNode(NetData: (data: NSData?)->Void) {
        GETRequest("\(V2EXBaseURL)/nodes/all.json", NetData: NetData)
    }
    //取节点信息
    func findNodeInfo(id: String?, nodeName: String?, NetData: (data: NSData?)->Void) {
        var URLString: String?
        if let id = id {
            URLString = "\(V2EXBaseURL)/nodes/show.json?id=\(id)"
        }else if let nodeName = nodeName {
            URLString = "\(V2EXBaseURL)/nodes/show.json?name=\(nodeName)"
        }
        if let URLString = URLString {
            GETRequest(URLString, NetData: NetData)
        }
    }
    //取最新主题
    func findLatestTopics(NetData: (data: NSData?)->Void) {
        GETRequest("\(V2EXBaseURL)/topics/latest.json", NetData: NetData)
    }
    //取热议主题
    func findHotTopics(NetData: (data: NSData?)->Void) {
        GETRequest("\(V2EXBaseURL)/topics/hot.json", NetData: NetData)
    }
    //取主题信息
    func findTopicsInfo(topicId: String, NetData: (data: NSData?)->Void) {
        GETRequest("\(V2EXBaseURL)/topics/show.json?id=\(topicId)", NetData: NetData)
    }
    //根据提供信息取主题
    func findTopics(username: String?, nodeId: String?, nodeName: String?, NetData: (data: NSData?)->Void) {
        var URLString: String?
        if let username = username {//根据用户名取该用户所发表主题
            URLString = "\(V2EXBaseURL)/topics/show.json?username=\(username)"
        }else if let nodeId = nodeId {//根据节点id取该节点下所有主题
            URLString = "\(V2EXBaseURL)/topics/show.json?node_id=\(nodeId)"
        }else if let nodeName = nodeName {//根据节点名取该节点下所有主题
            URLString = "\(V2EXBaseURL)/topics/show.json?node_name=\(nodeName)"
        }
        if let URLString = URLString {
            GETRequest(URLString, NetData: NetData)
        }
    }  
    //取主题回复
    func findReplies(topicId: String, page: String?, NetData: (data: NSData?)->Void) {
        var URLString: String?
        if let page = page {
            URLString = "\(V2EXBaseURL)/replies/show.json?topic_id=\(topicId)&page=\(page)&page_size=\(pageSize)"
        }else {
            URLString = "\(V2EXBaseURL)/replies/show.json?topic_id=\(topicId)"
        }
        if let URLString = URLString {
            GETRequest(URLString, NetData: NetData)
        }
    }
    //取用户信息
    func findmembers(id: String?, username: String?, NetData: (data: NSData?)->Void) {
        var URLString: String?
        if let id = id {
            URLString = "\(V2EXBaseURL)/members/show.json?id=\(id)"
        }else if let username = username {
            URLString = "\(V2EXBaseURL)/members/show.json?username=\(username)"
        }
        if let URLString = URLString {
            GETRequest(URLString, NetData: NetData)
        }
    }
}