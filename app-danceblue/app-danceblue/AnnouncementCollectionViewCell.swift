//
//  AnnouncementTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/23/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class AnnouncementCollectionViewCell: UICollectionViewCell, AnnouncementDelegate {

    static let identifier = "AnnouncementCell"
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var announcementImageView: UIImageView!
    @IBOutlet weak var announcementLabel: UILabel!
    
    private var announcement: Announcement?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        
        shadowView.layer.cornerRadius = 10.0
        shadowView.layer.shadowRadius = 10.0
        shadowView.layer.shadowColor = Styles.black.cgColor
        shadowView.layer.shadowOpacity = 0.1
        
        background.layer.cornerRadius = 10.0
        background.clipsToBounds = true
    }
    
    func configureCell(with announcement: Announcement, for indexPath: IndexPath) {
        announcementLabel.text = announcement.text
        announcement.delegate = self
    }
    
    func announcement(didFinishDownloadingImage image: UIImage) {
        announcementImageView.image = image
    }
    
    
    
}
