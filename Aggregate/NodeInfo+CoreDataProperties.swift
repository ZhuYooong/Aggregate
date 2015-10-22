//
//  NodeInfo+CoreDataProperties.swift
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

extension NodeInfo {

    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var url: String?
    @NSManaged var title: String?
    @NSManaged var title_alternative: String?
    @NSManaged var topics: String?
    @NSManaged var header: String?
    @NSManaged var footer: String?
    @NSManaged var created: String?

}
