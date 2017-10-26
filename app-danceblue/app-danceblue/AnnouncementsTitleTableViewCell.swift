//
//  AnnouncementsTitleTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 10/17/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class AnnouncementsTitleTableViewCell: UITableViewCell {

    static let identifier = "AnnouncementsTitleCell"
    
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = "ANNOUNCEMENTS"
        titleLabel.font = Theme.Font.header
        underlineView.backgroundColor = Theme.Color.main
    }

}
