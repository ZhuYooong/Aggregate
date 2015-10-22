//
//  TopicInfo+CoreDataProperties.swift
//  Aggregate
//
//  Created by MAC on 15/10/22.
//  Copyright © 2015年 朱勇. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TopicInfo {

    @NSManaged var id: String?
    @NSManaged var title: String?
    @NSManaged var url: String?
    @NSManaged var content: String?
    @NSManaged var content_rendered: String?
    @NSManaged var replies: String?
    @NSManaged var member_id: String?
    @NSManaged var node_id: String?
    @NSManaged var created: String?
    @NSManaged var last_modified: String?
    @NSManaged var last_touched: String?
    @NSManaged var member_username: String?
    @NSManaged var member_tagline: String?
    @NSManaged var member_avatar_mini: String?
    @NSManaged var member_avatar_normal: String?
    @NSManaged var member_avatar_large: String?
    @NSManaged var node_name: String?
    @NSManaged var node_title: String?
    @NSManaged var node_url: String?
    @NSManaged var node_topics: String?
    @NSManaged var node_avatar_mini: String?
    @NSManaged var node_avatar_normal: String?
    @NSManaged var node_avatar_large: String?

}
