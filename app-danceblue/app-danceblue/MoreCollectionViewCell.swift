//
//  MoreCollectionViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/25/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class MoreCollectionViewCell: UICollectionViewCell {
        
        static let identifier = "MoreCell"
        
    @IBOutlet weak var moreImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
        
        private var details: BlogDetails?
        private var isImageDownloaded: Bool = false
        
        override func awakeFromNib() {
            moreImageView.layer.cornerRadius = 5.0
            moreImageView.clipsToBounds = true
        }
        
    func configureCell(with image: UIImage, title: String) {
        moreImageView.image = image
        titleLabel.text = title
        
    }
    
}
