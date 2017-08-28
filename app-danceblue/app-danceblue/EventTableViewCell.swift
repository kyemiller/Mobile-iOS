//
//  EventTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import FirebaseStorage
import NVActivityIndicatorView


class EventTableViewCell: UITableViewCell {
    
    static let identifier = "EventCell"
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var loadingIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    let gradient = CAGradientLayer()

    private var event: Event?
    private var indexPath: IndexPath?
    fileprivate var isImageDownloaded: Bool = false
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        headerImageView.layer.cornerRadius = 10.0
        headerImageView.clipsToBounds = true
        headerImageView.backgroundColor = Theme.Color.background
    }

    // MARK: - Configuration
    
    func configureCell(with event: Event, for indexPath: IndexPath) {
        self.event = event
        self.indexPath = indexPath
        event.delegate = self
        
        setupLoadingIndicator()
        updateWithContent()
        layoutHeaderImage()
    }
    
    func updateWithContent() {
        titleLabel.text = event?.title
        descriptionLabel.text = event?.location
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM dd, yyyy"
        dateLabel.text = formatter.string(from: event?.timestamp ?? Date())
        timeLabel.text = event?.time
    }

    
    func setupLoadingIndicator() {
        loadingIndicatorView.color = Theme.Color.loader
        loadingIndicatorView.type = .ballScale
        if !isImageDownloaded {
            loadingIndicatorView.startAnimating()
        }
    }
    
    // MARK: - Layout
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        let x = headerImageView.sizeThatFits(CGSize(width: size.width - 40.0, height: .greatestFiniteMagnitude)).height + dateLabel.sizeThatFits(CGSize(width: size.width - 40.0, height: .greatestFiniteMagnitude)).height
        
        return CGSize(width: size.width, height: x)
    }
    
    func layoutHeaderImage() {
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.colors = [Theme.Color.clear.cgColor, Theme.Color.black.cgColor]
        gradient.frame = headerImageView.frame
        gradient.cornerRadius = 10.0
    }
    
}

// MARK: - Event Delegate

extension EventTableViewCell: EventDelegate {
    
    func event(didFinishDownloadingImage image: UIImage) {
        headerImageView?.image = image
        headerImageView.layer.addSublayer(gradient)
        loadingIndicatorView.stopAnimating()
        isImageDownloaded = true
    }
    
}
