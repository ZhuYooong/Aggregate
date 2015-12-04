//
//  Replies.swift
//  Aggregate
//
//  Created by 朱勇 on 15/11/3.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class Replies: NSObject {
    var id: String?
    var thanks: String?
    var content: String?
    var content_rendered: String?
    var member_id: String?
    var member_username: String?
    var member_tagline: String?
    var member_avatar_mini: String?
    var member_avatar_normal: String?
    var member_avatar_large: String?
    var created: String?
    var last_modified: String?
    
    init(id: String?, thanks: String?, content: String?, content_rendered: String?, member_id: String?, member_username: String?, member_tagline: String?, member_avatar_mini: String?, member_avatar_normal: String?, member_avatar_large: String?, created: String?, last_modified: String?) {
        self.id = id
        self.thanks = thanks
        self.content = content
        self.content_rendered = content_rendered
        self.member_id = member_id
        self.member_username = member_username
        self.member_tagline = member_tagline
        self.member_avatar_mini = member_avatar_mini
        self.member_avatar_normal = member_avatar_normal
        self.member_avatar_large = member_avatar_large
        self.created = created
        self.last_modified = last_modified
    }
}
