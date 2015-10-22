//
//  TopicTableViewCell.swift
//  Aggregate
//
//  Created by MAC on 15/10/22.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {
    @IBOutlet weak var topicContent: UILabel!
    @IBOutlet weak var topicContentHeight: NSLayoutConstraint!
    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var topicTimeLable: UILabel!
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var nodeLable: UILabel!
    @IBOutlet weak var nodeWidth: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
