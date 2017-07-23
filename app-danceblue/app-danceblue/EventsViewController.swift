//
//  EventsViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class EventsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
    }
    
    func setUpNavigation() {
        guard let navigation = self.navigationController?.navigationBar else { return }
        
        self.title = "Events"
        navigation.tintColor = Styles.mainColor
        navigation.isTranslucent = true
        navigation.barTintColor = Styles.white
        navigation.titleTextAttributes = [NSForegroundColorAttributeName : Styles.mainColor]
    }
}
