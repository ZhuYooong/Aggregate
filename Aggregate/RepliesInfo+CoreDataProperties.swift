//
//  RepliesInfo+CoreDataProperties.swift
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

extension RepliesInfo {

    @NSManaged var id: String?
    @NSManaged var thanks: String?
    @NSManaged var content: String?
    @NSManaged var content_rendered: String?
    @NSManaged var member_id: String?
    @NSManaged var member_username: String?
    @NSManaged var member_tagline: String?
    @NSManaged var member_avatar_mini: String?
    @NSManaged var member_avatar_normal: String?
    @NSManaged var member_avatar_large: String?
    @NSManaged var created: String?
    @NSManaged var last_modified: String?

}
