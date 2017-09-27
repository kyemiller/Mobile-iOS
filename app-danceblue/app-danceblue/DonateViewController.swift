//
//  DonateViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import SafariServices

class DonateViewController: UIViewController {
    
    @IBOutlet weak var donateTextView: UITextView!
    @IBOutlet weak var donateImageView: UIImageView!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donateImageView.clipsToBounds = true
        donateImageView.layer.cornerRadius = 5.0
        
        donateTextView.showsVerticalScrollIndicator = true
        donateTextView.tintColor = Theme.Color.main
        donateTextView.backgroundColor = Theme.Color.clear
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpNavigation(controller: navigationController, hidesBar: false)
        self.title = "Donate"
    }

    @IBAction func didTapDonate(_ sender: Any) {
        if let url = URL(string: "https://danceblue.networkforgood.com") {
            let svc = SFSafariViewController(url: url)
            svc.preferredControlTintColor = Theme.Color.main
            self.present(svc, animated: true, completion: nil)
        }
    }
    
}
