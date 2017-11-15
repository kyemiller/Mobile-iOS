//
//  EventDetailsViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/23/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import EventKit
import FirebaseAnalytics
import SafariServices
import UIKit

class EventDetailsViewController: UITableViewController {
    
    var event: Event?
    var cellHeights: [CGFloat] = [CGFloat].init(repeating: 0, count: 5)
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController?.isNavigationBarHidden ?? false {
            navigationController?.setNavigationBarHidden(false, animated: false)
        }
        Analytics.logEvent("Event_Did_Appear", parameters: ["Title" : event?.title ?? ""])
        setUpNavigation(controller: navigationController, hidesBar: false)
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))
        
    }
    
    // MARK: - TableView Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if event?.flyer != nil && event?.map != nil { return 5 }
        else if event?.flyer != nil || event?.map != nil { return 4 }
        return 3
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
                descriptionCell.delegate = self
                if cellHeights[indexPath.row] == 0 {
                    cellHeights[indexPath.row] = descriptionCell.sizeThatFits(CGSize(width: view.bounds.width, height: .greatestFiniteMagnitude)).height
                }
                
                return descriptionCell
            }
        case 3:
            if event.flyer != nil, let flyerCell = tableView.dequeueReusableCell(withIdentifier: EventFlyerCell.identifier, for: indexPath) as? EventFlyerCell {
                flyerCell.configureCell(with: event)
                if cellHeights[indexPath.row] == 0 {
                    cellHeights[indexPath.row] = flyerCell.sizeThatFits(CGSize(width: view.bounds.width, height: .greatestFiniteMagnitude)).height
                }
                return flyerCell
            } else {
                if let mapCell = tableView.dequeueReusableCell(withIdentifier: EventMapCell.identifier, for: indexPath) as? EventMapCell {
                    mapCell.configureCell(with: event)
                    if cellHeights[indexPath.row] == 0 {
                        cellHeights[indexPath.row] = mapCell.sizeThatFits(CGSize(width: view.bounds.width, height: .greatestFiniteMagnitude)).height
                    }
                    
                    return mapCell
                }
            }
        case 4:
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("HERE")
        if segue.identifier == "FlyerSegue", let ivc = segue.destination as? ImageViewController {
            ivc.setupViews(with: event?.flyer)
        }
    }
    
}

// MARK: - EventDescriptionDelegate

extension EventDetailsViewController: EventDescriptionDelegate {
    
    func textView(didPresentSafariViewController url: URL) {
        let svc = SFSafariViewController(url: url)
        svc.preferredControlTintColor = Theme.Color.main
        self.present(svc, animated: true, completion: nil)
    }
    
}

