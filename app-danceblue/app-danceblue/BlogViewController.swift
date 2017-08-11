//
//  BlogViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/31/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BlogViewController: UIViewController, BlogCollectionViewDelegate {
        
    private var blogCollectionViewController: BlogCollectionViewController?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loadingIndicatorView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        containerView.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    func setupLoadingIndicator() {
        loadingIndicatorView.color = Styles.segmentControllerTintColor
        loadingIndicatorView.type = .ballScale
        loadingIndicatorView.startAnimating()
    }
    
    func setupNavigation() {
        guard let navigation = self.navigationController?.navigationBar else { return }
        
        self.title = "Blog"
        navigation.tintColor = Styles.black
        navigation.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Helvetica-Bold", size: 24.0) ?? UIFont(), NSForegroundColorAttributeName : Styles.black]
        navigation.isTranslucent = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func collectionDidLoad() {
        loadingIndicatorView.stopAnimating()
        containerView.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let blogVC = segue.destination as? BlogCollectionViewController, segue.identifier == "BlogEmbedSegue" {
            blogCollectionViewController = blogVC
            blogCollectionViewController?.delegate = self
        }
    }
        
}
