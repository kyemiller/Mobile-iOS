//
//  EventDetailsViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/23/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import EventKit
import MapKit
import NVActivityIndicatorView


class EventDetailsViewController: UIViewController, EventDelegate {

    var event: Event?
    let locationManager = CLLocationManager()

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        event?.delegate = self
        setupLoadingIndicator()
        setupNavigation()
        setupHeaderImage()
    }
    
    func setupHeaderImage() {
        headerImage.clipsToBounds = true
        if event?.image == nil {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
            headerImage.image = event?.image
        }
        
    }
    
    func setupLoadingIndicator() {
        loadingIndicator.color = .darkGray
        loadingIndicator.type = .ballScale
    }
    
    func setupNavigation() {
        guard let navigation = self.navigationController?.navigationBar else { return }
        navigation.isTranslucent = true
        navigation.tintColor = Styles.mainColor

    }
    
    // MARK: - EventDelegate
    
    func event(didFinishDownloadingImage image: UIImage) {
        setupHeaderImage()
    }

}
