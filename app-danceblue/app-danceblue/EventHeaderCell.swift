//
//  EventHeaderCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 9/18/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EventHeaderCell: UITableViewCell {
    
    static let identifier = "EventHeaderCell"
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    
    fileprivate var event: Event?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadingIndicator.color = Theme.Color.loader
        loadingIndicator.type = .ballScale
        headerImageView.clipsToBounds = true
        headerImageView.backgroundColor = Theme.Color.background
    }
    
    func configureCell(with event: Event) {
        self.event = event
        event.delegate = self
        setupViews()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let header = headerImageView else { return CGSize() }
        let height: CGFloat = header.frame.height + 8.0
        return CGSize(width: bounds.width, height: height)
    }
    
    func setupViews() {
        if event?.image == nil {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
            headerImageView.image = event?.image
        }
    }
    
}

// MARK: - EventDelegate

extension EventHeaderCell: EventDelegate {
    
    func event(didFinishDownloadingImage image: UIImage) {
        if event?.image == image {
            loadingIndicator.stopAnimating()
            headerImageView.image = image
        }
        
    }
    
    func event(didFinishDownloadingMap map: UIImage) {}
    
}
