//
//  BodyImageTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/3/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BodyImageTableViewCell: UITableViewCell, BlogDetailsBodyImageDelegate {
    
    static let identifier = "BodyImageCell"
    
    private var data: BCBodyImage?

    @IBOutlet weak var bodyImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate: BlogHeaderImageDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bodyImageView.clipsToBounds = true
        bodyImageView.backgroundColor = Theme.Color.background
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let adjustedHeight = descriptionLabel.sizeThatFits(CGSize(width: bounds.width - 40.0, height: size.height)).height + bodyImageView.frame.height + 12.0

        return CGSize(width: bounds.width, height: adjustedHeight)
    }
    
    func configureCell(with data: BCBodyImage) {
        self.data = data
        data.delegate = self
        descriptionLabel.text = data.description
        setupViews()
    }
    
    func setupViews() {
        loadingIndicator.type = .ballScale
        loadingIndicator.color = Theme.Color.loader
        if data?.image == nil {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
            bodyImageView.image = data?.image
        }
    }

    // MARK: - BlogDetailsBodyImageDelegate
    
    func bodyImage(didFinishDownloading image: UIImage?) {
        bodyImageView.image = image
        loadingIndicator.stopAnimating()
    }
}
