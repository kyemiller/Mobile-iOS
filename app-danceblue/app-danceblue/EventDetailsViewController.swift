//
//  EventDetailsViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/23/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import EventKit
import MapKit
import NVActivityIndicatorView


class EventDetailsViewController: UITableViewController {
    
    var event: Event?
    var cellHeights: [CGFloat] = [CGFloat].init(repeating: 0, count: 4)
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController?.isNavigationBarHidden ?? false {
            navigationController?.setNavigationBarHidden(false, animated: false)
        }
        setUpNavigation(controller: navigationController, hidesBar: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
    }
    
    // MARK: - Tableview
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let event = event else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            if let headerCell = tableView.dequeueReusableCell(withIdentifier: EventHeaderCell.identifier, for: indexPath) as? EventHeaderCell {
                headerCell.configureCell(with: event)
                if cellHeights[indexPath.row] == 0 {
                    cellHeights[indexPath.row] = headerCell.sizeThatFits(CGSize(width: view.bounds.width, height: .greatestFiniteMagnitude)).height
                }
                
                return headerCell
            }
        case 1:
            if let detailsCell = tableView.dequeueReusableCell(withIdentifier: EventDetailsTableViewCell.identifier, for: indexPath) as? EventDetailsTableViewCell {
                detailsCell.configureCell(with: event)
                if cellHeights[indexPath.row] == 0 {
                    cellHeights[indexPath.row] = detailsCell.sizeThatFits(CGSize(width: view.bounds.width, height: .greatestFiniteMagnitude)).height
                }
                
                return detailsCell
            }
        case 2:
            if let descriptionCell = tableView.dequeueReusableCell(withIdentifier: EventDescriptionCell.identifier, for: indexPath) as? EventDescriptionCell {
                descriptionCell.configureCell(with: event)
                if cellHeights[indexPath.row] == 0 {
                    cellHeights[indexPath.row] = descriptionCell.sizeThatFits(CGSize(width: view.bounds.width, height: .greatestFiniteMagnitude)).height
                }
                
                return descriptionCell
            }
        case 3:
            if let mapCell = tableView.dequeueReusableCell(withIdentifier: EventMapCell.identifier, for: indexPath) as? EventMapCell {
                mapCell.configureCell(with: event)
                if cellHeights[indexPath.row] == 0 {
                    cellHeights[indexPath.row] = mapCell.sizeThatFits(CGSize(width: view.bounds.width, height: .greatestFiniteMagnitude)).height
                }
                
                return mapCell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    
    func share() {
        
    }
    
}
