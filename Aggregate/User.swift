//
//  User.swift
//  Aggregate
//
//  Created by 朱勇 on 15/11/3.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class User: NSObject {
    var status: String?
    var id: String?
    var url: String?
    var username: String?
    var website: String?
    var twitter: String?
    var psn: String?
    var github: String?
    var btc: String?
    var location: String?
    var tagline: String?
    var bio: String?
    var avatar_mini: String?
    var avatar_normal: String?
    var avatar_large: String?
    var created: String?
    
    init(status: String?, id: String?, url: String?, username: String?, website: String?, twitter: String?, psn: String?, github: String?, btc: String?, location: String?, tagline: String?, bio: String?, avatar_mini: String?, avatar_normal: String?, avatar_large: String?, created: String?) {
        self.status = status
        self.id = id
        self.url = url
        self.username = username
        self.website = website
        self.twitter = twitter
        self.psn = psn
        self.github = github
        self.btc = btc
        self.location = location
        self.tagline = tagline
        self.bio = bio
        self.avatar_mini = avatar_mini
        self.avatar_normal = avatar_normal
        self.avatar_large = avatar_large
        self.created = created
    }
}
