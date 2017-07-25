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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
    }
    
    func setUpNavigation() {
        guard let navigation = self.navigationController?.navigationBar else { return }
        
        self.title = "Donate"
        navigation.tintColor = Styles.mainColor
        navigation.isTranslucent = true
        navigation.barTintColor = Styles.white
        navigation.titleTextAttributes = [NSForegroundColorAttributeName : Styles.mainColor]
    }

    @IBAction func didTapDonate(_ sender: Any) {
        if let url = URL(string: "https://danceblue.networkforgood.com") {
            let svc = SFSafariViewController(url: url)
            svc.preferredControlTintColor = Styles.mainColor
            self.present(svc, animated: true, completion: nil)
        }
    }
}
