//
//  BlogVerticalCollectionViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/31/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BlogVerticalCollectionViewCell: UICollectionViewCell, BlogDetailsDelegate {
    
    static let identifier = "BlogVerticalCell"
    
    @IBOutlet weak var blogImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    
    private var details: BlogDetails?
    private var isImageDownloaded: Bool = false
    
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
        } else {
            loadingIndicator.stopAnimating()
            blogImageView.image = details?.image
        }
    }
    
    func blog(didFinishDownloading image: UIImage) {
        blogImageView?.image = image
        loadingIndicator.stopAnimating()
        isImageDownloaded = true
    }
    
}
