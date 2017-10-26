//
//  AnnouncementTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 10/17/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import Kingfisher

class AnnouncementTableViewCell: UITableViewCell {

    static let identifier = "AnnouncementCell"
    
    @IBOutlet weak var announcementLabel: UILabel!
    @IBOutlet weak var announcementImageView: UIImageView!
    
    override func awakeFromNib() {
        announcementImageView.layer.cornerRadius = 5.0
        announcementImageView.clipsToBounds = true
    }
    
    func configureCell(with announcement: Announcement) {
        announcementLabel.text = announcement.text
        guard let istring = announcement.imageString else { return }
        let url = URL(string: istring)
        
        announcementImageView.kf.setImage(with: url!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cache, url) in
            log.debug("Image displayed using KingFisher")
        }
    }

}
