//
//  GalleryCollectionViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 10/16/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Kingfisher
import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GalleryCollectionCell"
    
    @IBOutlet weak var galleryImageView: UIImageView!
    
    override func awakeFromNib() {
        galleryImageView.backgroundColor = Theme.Color.background
        galleryImageView.layer.cornerRadius = 5.0
        galleryImageView.clipsToBounds = true
    }
    
    func configureCell(with url: URL) {
        galleryImageView.kf.setImage(with: url)
    }
    
}
