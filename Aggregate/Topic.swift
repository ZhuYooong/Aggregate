//
//  Topic.swift
//  Aggregate
//
//  Created by 朱勇 on 15/11/3.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class Topic: NSObject {
    var id: String?
    var title: String?
    var url: String?
    var content: String?
    var content_rendered: String?
    var replies: String?
    var member_id: String?
    var node_id: String?
    var created: String?
    var last_modified: String?
    var last_touched: String?
    var member_username: String?
    var member_tagline: String?
    var member_avatar_mini: String?
    var member_avatar_normal: String?
    var member_avatar_large: String?
    var node_name: String?
    var node_title: String?
    var node_url: String?
    var node_topics: String?
    var node_avatar_mini: String?
    var node_avatar_normal: String?
    var node_avatar_large: String?
    
    init(id: String?, title: String?, url: String?, content: String?, content_rendered: String?, replies: String?, member_id: String?, node_id: String?, created: String?, last_modified: String?, last_touched: String?, member_username: String?, member_tagline: String?, member_avatar_mini: String?, member_avatar_normal: String?, member_avatar_large: String?, node_name: String?, node_title: String?, node_url: String?, node_topics: String?, node_avatar_mini: String?, node_avatar_normal: String?, node_avatar_large: String?) {
        self.id = id
        self.title = title
        self.url = url
        self.content = content
        self.content_rendered = content_rendered
        self.replies = replies
        self.member_id = member_id
        self.node_id = node_id
        self.created = created
        self.last_modified = last_modified
        self.last_touched = last_touched
        self.member_username = member_username
        self.member_tagline = member_tagline
        self.member_avatar_mini = member_avatar_mini
        self.member_avatar_normal = member_avatar_normal
        self.member_avatar_large = member_avatar_large
        self.node_name = node_name
        self.node_title = node_title
        self.node_url = node_url
        self.node_topics = node_topics
        self.node_avatar_mini = node_avatar_mini
        self.node_avatar_normal = node_avatar_normal
        self.node_avatar_large = node_avatar_large
    }
}
