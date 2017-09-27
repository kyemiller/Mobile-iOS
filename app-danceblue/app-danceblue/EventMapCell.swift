//
//  EventMapCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 9/21/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import UIKit

class EventMapCell: UITableViewCell {
    
    static let identifier = "EventMapCell"
    
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    
    let tapRecognizer = UITapGestureRecognizer()
    fileprivate var event: Event?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapImageView.clipsToBounds = true
        mapImageView.layer.cornerRadius = 5.0
        mapImageView.backgroundColor = Theme.Color.background
        tapRecognizer.addTarget(self, action: #selector(mapTapped))
        self.addGestureRecognizer(tapRecognizer)

    }
    
    func mapTapped() {
        if event?.address != nil {
            UIApplication.shared.open(Router.Maps.buildAddressURL(from: (event?.address)!), options: [:], completionHandler: nil)
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let adjustedHeight = mapImageView.frame.height + 16.0
        return CGSize(width: bounds.width, height: adjustedHeight)
    }
    
    func configureCell(with event: Event) {
        self.event = event
        setupViews()
    }
    
    func setupViews() {
        loadingIndicator.type = .ballScale
        loadingIndicator.color = Theme.Color.loader
        if event?.map == nil {
            loadingIndicator.startAnimating()
        } else {
            mapImageView.image = event?.map
            loadingIndicator.stopAnimating()
        }
    }
    
}

// MARK: - Event Delegate

extension EventMapCell: EventDelegate {
    
    func event(didFinishDownloadingImage image: UIImage) {}
    
    func event(didFinishDownloadingMap map: UIImage) {
        if map == event?.map {
            mapImageView?.image = map
            loadingIndicator.stopAnimating()
        }
    }
    
}
