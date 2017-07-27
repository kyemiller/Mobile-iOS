//
//  AnnouncementTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/23/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class AnnouncementTableViewCell: UITableViewCell {

    static let identifier = "AnnouncementCell"
    
    @IBOutlet weak var announcementLabel: UILabel!
    
    private var announcement: Announcement?
    
    // MARK: - Initialization
    
    func configureCell(with announcement: Announcement, for indexPath: IndexPath) {
        announcementLabel.text = announcement.text
    }
    
}
