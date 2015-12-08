//
//  UserInfoViewModel.swift
//  Aggregate
//
//  Created by MAC on 15/11/10.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData
class UserInfoViewModel: NSObject {
    var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext //获取存储的上下文
    static let shareUserInfoViewModel = UserInfoViewModel()
    private override init() {}
    //MARK: - 网络请求
    func findmembers(id: String?, username: String?, initData: (content: User?)->Void) {//取用户信息
        NetDataManager.shareNetDataManager.findmembers(id, username: username) { (data) -> Void in
            if let data = data {
                let json = JSON(data: data)
                    let subJson = json.dictionaryValue
                    let userInfo = User(status: subJson["status"]?.stringValue, id: subJson["id"]?.stringValue, url: subJson["url"]?.stringValue, username: subJson["username"]?.stringValue, website: subJson["website"]?.stringValue, twitter: subJson["twitter"]?.stringValue, psn: subJson["psn"]?.stringValue, github: subJson["github"]?.stringValue, btc: subJson["btc"]?.stringValue, location: subJson["location"]?.stringValue, tagline: subJson["tagline"]?.stringValue, bio: subJson["bio"]?.stringValue, avatar_mini: subJson["avatar_mini"]?.stringValue, avatar_normal: subJson["avatar_normal"]?.stringValue, avatar_large: subJson["avatar_large"]?.stringValue, created: subJson["created"]?.stringValue)
                    initData(content: userInfo)
            }
        }
    }
    //MARK: - 数据逻辑
    func findMineInfo(userName: String, mineInfo: (User) -> Void) {//我的信息
        let fetchRequest = NSFetchRequest(entityName: "UserInfo")
        fetchRequest.predicate = NSPredicate(format: "username == %@", userName)
        do {
            let fetchResults = try context.executeFetchRequest(fetchRequest) as? [UserInfo]
            if let fetchResults = fetchResults where fetchResults.count > 0 {
                if let mineItem = fetchResults.last {
                    let userInfo = User(status: mineItem.status, id: mineItem.id, url: mineItem.url, username: mineItem.username, website: mineItem.website, twitter: mineItem.twitter, psn: mineItem.psn, github: mineItem.github, btc: mineItem.btc, location: mineItem.location, tagline: mineItem.tagline, bio: mineItem.bio, avatar_mini: mineItem.avatar_mini, avatar_normal: mineItem.avatar_normal, avatar_large: mineItem.avatar_large, created: mineItem.created)
                    mineInfo(userInfo)
                }
            }
        } catch let error1 as NSError {
            print(error1)
        }
    }
    func insertMineInfo(insertInfo: User) {//插入我的信息
        do {
            let entity = NSEntityDescription.insertNewObjectForEntityForName("UserInfo", inManagedObjectContext: context) as! UserInfo
            entity.status = insertInfo.status
            entity.id = insertInfo.id
            entity.url = insertInfo.url
            entity.username = insertInfo.username
            entity.website = insertInfo.website
            entity.twitter = insertInfo.twitter
            entity.psn = insertInfo.psn
            entity.github = insertInfo.github
            entity.btc = insertInfo.btc
            entity.location = insertInfo.location
            entity.tagline = insertInfo.tagline
            entity.bio = insertInfo.bio
            entity.avatar_mini = insertInfo.avatar_mini
            entity.avatar_normal = insertInfo.avatar_normal
            entity.avatar_large = insertInfo.avatar_large
            entity.created = insertInfo.created
            try context.save()
        } catch let error1 as NSError {
            print(error1)
        }
    }
    func removeMineInfo(userName: String?) {//删除我的信息
        if let userName = userName {
            let fetchRequest = NSFetchRequest(entityName: "UserInfo")
            fetchRequest.predicate = NSPredicate(format: "username == %@", userName)
            do {
                let fetchResults = try context.executeFetchRequest(fetchRequest) as? [UserInfo]
                if let fetchResults = fetchResults where fetchResults.count > 0 {
                    for mineInfo in fetchResults {
                        context.deleteObject(mineInfo)
                        try context.save()
                    }
                }
            } catch let error1 as NSError {
                print(error1)
            }
        }
    }
}
