//
//  HeaderImageTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/1/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HeaderImageTableViewCell: UITableViewCell {

    static let identifier = "HeaderImageCell"
    
    private var data: BCHeaderImage?
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerImageView.clipsToBounds = true
        headerImageView.backgroundColor = Theme.Color.background
    }
    
    func configureCell(with data: BCHeaderImage) {
        self.data = data
        data.delegate = self
        setupViews()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let header = headerImageView else { return CGSize() }
        let height: CGFloat = descriptionLabel.sizeThatFits(CGSize(width: size.width - 40.0, height: .greatestFiniteMagnitude)).height + header.frame.height + 8.0 + 8.0 + 8.0
        return CGSize(width: bounds.width, height: height)
        
    }
    
    func setupViews() {
        loadingIndicator.color = Theme.Color.loader
        loadingIndicator.type = .ballScale
        descriptionLabel.text = data?.description
        if data?.image == nil {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
            headerImageView.image = data?.image
        }
    }
    
}

// MARK: - BlogDetailsHeaderImageDelegate

extension HeaderImageTableViewCell: BlogDetailsHeaderImageDelegate {
    
    func headerImage(didFinishDownloading image: UIImage?) {
        loadingIndicator.stopAnimating()
        headerImageView.image = image
    }
    
}