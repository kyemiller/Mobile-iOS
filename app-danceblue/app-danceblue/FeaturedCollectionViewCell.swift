//
//  FeaturedCollectionViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/31/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class FeaturedCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FeaturedCell"
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    
    @IBOutlet weak var featuredLabel: UILabel!
    @IBOutlet weak var featuredUnderlineView: UIView!
    @IBOutlet weak var recentLabel: UILabel!
    @IBOutlet weak var recentUnderlineView: UIView!
    
    fileprivate var details: BlogDetails?
    fileprivate var isImageDownloaded: Bool = false
    
    override func awakeFromNib() {
        featuredImageView.layer.cornerRadius = 5.0
        featuredImageView.clipsToBounds = true
        featuredImageView.backgroundColor = Theme.Color.background
        
        featuredLabel.font = Theme.Font.header
        featuredLabel.textColor = Theme.Color.black
        featuredUnderlineView.backgroundColor = Theme.Color.main
        
        recentLabel.font = Theme.Font.header
        recentLabel.textColor = Theme.Color.black
        recentUnderlineView.backgroundColor = Theme.Color.main
        
        loadingIndicator.color = Theme.Color.loader
        loadingIndicator.type = .ballScale
        loadingIndicator.startAnimating()
    }
    
    func configureCell(with details: BlogDetails) {
        self.details = details
        details.delegate = self
        updateWithContent()
        setupViews()
    }
    
    func updateWithContent() {
        authorLabel.text = details?.author
        titleLabel.text = details?.title
    }
    
    func setupViews() {
        if details?.image == nil {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
            featuredImageView.image = details?.image
        }
    }
    
}

// MARK: - BlogDetailsDelegate

extension FeaturedCollectionViewCell: BlogDetailsDelegate {
    
    func blog(didFinishDownloading image: UIImage) {
        if details?.image == image {
            featuredImageView?.image = image
            loadingIndicator.stopAnimating()
            isImageDownloaded = true
        }
    }
    
}
