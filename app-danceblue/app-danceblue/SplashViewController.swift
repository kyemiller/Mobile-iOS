//
//  SplashViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/25/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SplashViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var containerView: UIView!

    private var homeViewController: HomeViewController?
    let networkController = UIAlertController(title: "Network Error", message: "We can't find an internet connection. Would you like to try again?", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNetworkContoller()
        setupViews()
    }

    func setupViews() {
        backgroundView.alpha = 1.0
        backgroundView.isHidden = false
        containerView.isHidden = true
        logoImageView.layer.allowsEdgeAntialiasing = true
    }

    func transition() {
        containerView.isHidden = false
        UIView.animate(withDuration: 1.5) {
            self.backgroundView.alpha = 0.0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabBarController = segue.destination as? UITabBarController, segue.identifier == "HomeEmbedSegue" {
            guard let homeNavigationController = tabBarController.viewControllers?[0] as? UINavigationController else { return }
            homeViewController = homeNavigationController.viewControllers[0] as? HomeViewController
            homeViewController?.delegate = self
        }
    }
    
    // MARK: - Network Utilities
    
    func setupNetworkContoller() {
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let tryAgain = UIAlertAction(title: "Try Again", style: .default, handler: { (action) in
            self.checkNetwork()
        })
        networkController.addAction(tryAgain)
        networkController.addAction(cancel)
        checkNetwork()
    }
    
    func checkNetwork() {
        if currentReachabilityStatus == .notReachable {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)) {
                self.present(self.networkController, animated: true, completion: {})
            }
        }
    }
    
}

// MARK: - AnnouncementCollectionViewDelegate

extension SplashViewController: AnnouncementCollectionViewDelegate {
    
    func collectionViewDidLoad() {
        networkController.dismiss(animated: true, completion: nil)
        transition()
    }
    
}