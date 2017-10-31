//
//  BlogVerticalCollectionViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 08/30/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import Kingfisher

class BlogHorizontalCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BlogHorizontalCell"
    
    @IBOutlet weak var blogImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    fileprivate var details: BlogDetails?
    
    override func awakeFromNib() {
        blogImageView.layer.cornerRadius = 5.0
        blogImageView.clipsToBounds = true
        blogImageView.backgroundColor = Theme.Color.background
    }
    
    func configureCell(with details: BlogDetails) {
        self.details = details
        updateWithContent()
    }
    
    func updateWithContent() {
        authorLabel.text = details?.author
        titleLabel.text = details?.title
        blogImageView.kf.setImage(with: URL(string: details?.image ?? ""))
    }
    
}
