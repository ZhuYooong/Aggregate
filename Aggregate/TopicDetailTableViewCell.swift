//
//  TopicDetailTableViewCell.swift
//  Aggregate
//
//  Created by MAC on 15/10/30.
//  Copyright © 2015年 朱勇. All rights reserved.
//

import UIKit

class TopicDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var memberImageView: UIImageView!
    @IBOutlet weak var memberNameLable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var contentLable: UILabel!
    @IBOutlet weak var memberNameWidth: NSLayoutConstraint!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
