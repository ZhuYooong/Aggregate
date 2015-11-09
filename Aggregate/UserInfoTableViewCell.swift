//
//  UserInfoTableViewCell.swift
//  Aggregate
//
//  Created by MAC on 15/11/9.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var topicTitleLable: UILabel!
    @IBOutlet weak var nodeNameLable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var nodeNameWidth: NSLayoutConstraint!
    @IBOutlet weak var topicTitleHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
