//
//  SplashViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/25/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SplashViewController: UIViewController, AnnouncementsTableViewDelegate {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loadingIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var dateLabel: UILabel!
    

    private var homeViewController: HomeViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        backgroundView.alpha = 1.0
        backgroundView.isHidden = false
        containerView.isHidden = true
        setupLoadingIndicator()
        setupLabel()
    }
    
    func setupLabel() {
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEEE, MMMM d, yyyy"
        dateLabel.text = dateformatter.string(from: date)
    }
    
    func setupLoadingIndicator() {
        loadingIndicatorView.color = Styles.white
        loadingIndicatorView.type = .ballScale
        loadingIndicatorView.alpha = 0.8
        loadingIndicatorView.startAnimating()
    }
    
    func tableDidLoad() {
        transition()
    }

    func transition() {
        containerView.isHidden = false
        UIView.animate(withDuration: 2.0) {
            self.backgroundView.alpha = 0.0
            self.loadingIndicatorView.alpha = 0.0
        }
        loadingIndicatorView.stopAnimating()
        backgroundView.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabBarController = segue.destination as? UITabBarController, segue.identifier == "HomeEmbedSegue" {
            guard let homeNavigationController = tabBarController.viewControllers?[0] as? UINavigationController else { return }
            homeViewController = homeNavigationController.viewControllers[0] as? HomeViewController
            homeViewController?.delegate = self
        }
    }
    
}
