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
<<<<<<< Updated upstream
=======
    @IBOutlet weak var dateLabel: UILabel!
    
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
    }
    
    func setupLoadingIndicator() {
        loadingIndicatorView.color = .yellow
        loadingIndicatorView.type = .orbit
=======
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
>>>>>>> Stashed changes
        loadingIndicatorView.startAnimating()
    }
    
    func tableDidLoad() {
        transition()
    }
<<<<<<< Updated upstream
    // FIXME: - Doesn't Animate
    func transition() {
        containerView.isHidden = false
        UIView.animate(withDuration: 2.0) {
            self.backgroundView.alpha = 0.0
            self.loadingIndicatorView.alpha = 0.0
        }
        loadingIndicatorView.stopAnimating()
        backgroundView.isHidden = true
        
=======

    func transition() {
        containerView.isHidden = false
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.sync {
                UIView.animate(withDuration: 1.0) {
                    self.backgroundView.alpha = 0.0
                }

            }
        }
>>>>>>> Stashed changes
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabBarController = segue.destination as? UITabBarController, segue.identifier == "HomeEmbedSegue" {
<<<<<<< Updated upstream
            print("Here")
=======
>>>>>>> Stashed changes
            guard let homeNavigationController = tabBarController.viewControllers?[0] as? UINavigationController else { return }
            homeViewController = homeNavigationController.viewControllers[0] as? HomeViewController
            homeViewController?.delegate = self
        }
    }
    
}
