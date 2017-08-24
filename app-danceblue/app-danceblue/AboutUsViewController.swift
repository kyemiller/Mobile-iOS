//
//  AboutUsViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpNavigation()
    }
    
    func setUpNavigation() {
        guard let navigation = self.navigationController?.navigationBar else { return }
        
        self.title = "About Us"
        navigation.tintColor = Styles.black
        navigation.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Helvetica-Bold", size: 24.0) ?? UIFont(), NSForegroundColorAttributeName : Styles.black]
        navigation.isTranslucent = true
        navigation.barTintColor = Styles.white
    }

}


