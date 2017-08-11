//
//  EventsViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/23/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EventsViewController: UIViewController, EventsTableViewDelegate {

    private var eventsTableViewController: EventsTableViewController?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loadingIndicatorView: NVActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        containerView.isHidden = true
        setupNavigation()
        
        // Do any additional setup after loading the view.
    }
    
    func setupLoadingIndicator() {
        loadingIndicatorView.color = Styles.segmentControllerTintColor
        loadingIndicatorView.type = .ballScaleMultiple
        loadingIndicatorView.startAnimating()
    }
    
    func setupNavigation() {
        guard let navigation = self.navigationController?.navigationBar else { return }
        
        self.title = "DanceBlue"
        navigation.tintColor = Styles.black
        navigation.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Helvetica-Bold", size: 24.0) ?? UIFont(), NSForegroundColorAttributeName : Styles.black]
        navigation.isTranslucent = true
        navigation.barTintColor = Styles.white
    }

    func tableDidLoad() {
        loadingIndicatorView.stopAnimating()
        containerView.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let eventsVC = segue.destination as? EventsTableViewController, segue.identifier == "EventsEmbedSegue" {
            eventsTableViewController = eventsVC
            eventsTableViewController?.delegate = self
        }
    }
    
}
