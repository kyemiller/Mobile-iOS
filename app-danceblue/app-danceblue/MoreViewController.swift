//
//  MoreViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 10/20/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import SafariServices
import FirebaseAnalytics

class MoreViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpNavigation(controller: navigationController, hidesBar: false)
        self.title = "More"
        Analytics.logEvent("More View Controller Did Appear", parameters: nil)
    }

    func setupTableView() {
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let donateCell = tableView.dequeueReusableCell(withIdentifier: DonateTableViewCell.identifier, for: indexPath) as? DonateTableViewCell {
                return donateCell
            }
        case 1:
            if let faqCell = tableView.dequeueReusableCell(withIdentifier: FAQsTableViewCell.identifier, for: indexPath) as? FAQsTableViewCell {
                return faqCell
            }
        case 2:
            if let contactCell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell {
                return contactCell
            }
        case 3:
            if let donateCell = tableView.dequeueReusableCell(withIdentifier: DonateTableViewCell.identifier, for: indexPath) as? DonateTableViewCell {
                return donateCell
            }
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }

    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        if indexPath.row == 0 {
            if let url = URL(string: "https://danceblue.networkforgood.com") {
                let svc = SFSafariViewController(url: url)
                svc.preferredControlTintColor = Theme.Color.main
                self.present(svc, animated: true, completion: nil)
            }
        }
        
    }

}
