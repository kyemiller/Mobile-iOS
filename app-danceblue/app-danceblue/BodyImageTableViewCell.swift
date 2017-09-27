//
//  BodyImageTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/3/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Gifu

class BodyImageTableViewCell: UITableViewCell {
    
    static let identifier = "BodyImageCell"
    
    fileprivate var data: BCBodyImage?

    @IBOutlet weak var bodyImageView: GIFImageView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bodyImageView.clipsToBounds = true
        bodyImageView.backgroundColor = Theme.Color.background
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bodyImageView.prepareForReuse()
        bodyImageView.image = nil
    }
    
    func configureCell(with data: BCBodyImage) {
        self.data = data
        data.delegate = self
        descriptionLabel.text = data.description
        setupViews()
    }
    
    func setupViews() {
        guard let data = data else { return }
        loadingIndicator.type = .ballScale
        loadingIndicator.color = Theme.Color.loader
        if data.image == nil {
            loadingIndicator.startAnimating()
        } else {
            if data.isGif ?? false {
                bodyImageView.animate(withGIFData: data.data ?? Data())
            } else {
                bodyImageView.image = data.image
        }
            loadingIndicator.stopAnimating()
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let adjustedHeight = descriptionLabel.sizeThatFits(CGSize(width: size.width - 40.0, height: size.height)).height + bodyImageView.frame.height + 12.0
        
        return CGSize(width: bounds.width, height: adjustedHeight)
    }
    
}

// MARK: - BlogDetailsBodyImageDelegate

extension BodyImageTableViewCell: BlogDetailsBodyImageDelegate {
    
    func bodyImage(didFinishDownloading image: UIImage?) {
        guard let data = data else { return }
        if data.isGif ?? false {
            bodyImageView.animate(withGIFData: data.data ?? Data())
        } else {
            bodyImageView.image = image
        }
        loadingIndicator.stopAnimating()
    }
    
}
