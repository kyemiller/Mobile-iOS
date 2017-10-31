//
//  BodyImageTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/3/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import Kingfisher
import Gifu

class BodyImageTableViewCell: UITableViewCell {
    
    static let identifier = "BodyImageCell"
    
    fileprivate var data: BCBodyImage?

    @IBOutlet weak var bodyImageView: GIFImageView!
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
        descriptionLabel.text = data.description
        setupViews()
    }
    
    func setupViews() {
        guard let data = data else { return }
        if data.isGif ?? false {
                bodyImageView.animate(withGIFData: data.data ?? Data())
        } else {
                bodyImageView.kf.setImage(with: URL(string: data.image ?? ""))
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let adjustedHeight = descriptionLabel.sizeThatFits(CGSize(width: size.width - 40.0, height: size.height)).height + bodyImageView.frame.height + 12.0
        return CGSize(width: bounds.width, height: adjustedHeight)
    }
    
}
