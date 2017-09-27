//
//  BlogVerticalCollectionViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 08/30/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BlogHorizontalCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BlogHorizontalCell"
    
    @IBOutlet weak var blogImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    
    fileprivate var details: BlogDetails?
    fileprivate var isImageDownloaded: Bool = false
    
    override func awakeFromNib() {
        blogImageView.layer.cornerRadius = 5.0
        blogImageView.clipsToBounds = true
        blogImageView.backgroundColor = Theme.Color.background
        loadingIndicator.color = Theme.Color.loader
        loadingIndicator.type = .ballScale
        loadingIndicator.startAnimating()
    }
    
    func configureCell(with details: BlogDetails) {
        self.details = details
        details.delegate = self
        blogImageView.clipsToBounds = true
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
            blogImageView.image = nil
        } else {
            loadingIndicator.stopAnimating()
            blogImageView.image = details?.image
        }
    }
    
}

// MARK: - BlogDetailsDelegate

extension BlogHorizontalCollectionViewCell: BlogDetailsDelegate {
    
    func blog(didFinishDownloading image: UIImage) {
        if details?.image == image {
            blogImageView?.image = image
            loadingIndicator.stopAnimating()
            isImageDownloaded = true
        }
    }
    
}
