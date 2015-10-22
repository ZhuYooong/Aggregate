//
//  UserInfo+CoreDataProperties.swift
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

extension UserInfo {

    @NSManaged var status: String?
    @NSManaged var id: String?
    @NSManaged var url: String?
    @NSManaged var username: String?
    @NSManaged var website: String?
    @NSManaged var twitter: String?
    @NSManaged var psn: String?
    @NSManaged var github: String?
    @NSManaged var btc: String?
    @NSManaged var location: String?
    @NSManaged var tagline: String?
    @NSManaged var bio: String?
    @NSManaged var avatar_mini: String?
    @NSManaged var avatar_normal: String?
    @NSManaged var avatar_large: String?
    @NSManaged var created: String?

}
