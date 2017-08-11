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


class EventTableViewCell: UITableViewCell, EventDelegate {
    
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
    private var isImageDownloaded: Bool = false
    
    // MARK: - Initialization

    func configureCell(with event: Event, for indexPath: IndexPath) {

        self.event = event
        event.delegate = self
        
        setupLoadingIndicator()
        updateWithContent()
        layoutHeaderImage()
        layoutContainerShadow()
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
        loadingIndicatorView.color = Styles.loadingIndicatorColor
        loadingIndicatorView.type = .ballScale
        if !isImageDownloaded {
            loadingIndicatorView.startAnimating()
        }
    }
    
    // MARK: - Layout
    
    func layoutHeaderImage() {
        headerImageView.clipsToBounds = true
        headerImageView.backgroundColor = Styles.imageBackgroundColor
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.colors = [Styles.clear.cgColor, Styles.black.cgColor]
        gradient.frame = headerImageView.frame
    }
    
    func layoutContainerShadow() {
        containerView.layer.shadowColor = Styles.black.cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowRadius = 5.0
    }
    
    // MARK: - Event Delegate
    
    func event(didFinishDownloadingImage image: UIImage) {
        headerImageView?.image = image
        headerImageView.layer.addSublayer(gradient)
        loadingIndicatorView.stopAnimating()
        isImageDownloaded = true
    }

}
