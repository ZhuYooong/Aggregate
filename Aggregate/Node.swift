//
//  Node.swift
//  Aggregate
//
//  Created by 朱勇 on 15/11/3.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class Node: NSObject {
    var id: String?
    var name: String?
    var url: String?
    var title: String?
    var title_alternative: String?
    var topics: String?
    var header: String?
    var footer: String?
    var created: String?
    
    init(id: String?, name: String?, url: String?, title: String?, title_alternative: String?, topics: String?, header: String?, footer: String?, created: String?) {
        self.id = id
        self.name = name
        self.url = url
        self.title = title
        self.title_alternative = title_alternative
        self.topics = topics
        self.header = header
        self.footer = footer
        self.created = created
    }
}
