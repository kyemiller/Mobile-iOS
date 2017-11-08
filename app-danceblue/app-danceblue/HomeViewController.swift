//
//  HomeViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 10/13/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Firebase
import FirebaseDatabase
import Foundation
import UIKit
import FirebaseAnalytics
import SafariServices

protocol HomeDelegate: class {
    func tableDidLoad()
}

class HomeViewController: UITableViewController {
    
    private var cellHeights: [CGFloat] = [0.0, 56.0, 120.0, 240.0]
    
    private var announcementData: [Announcement] = []
    private var announcementMap: [String : Announcement] = [:]
    
    private var countdownDate: Date?
    private var countdownTitle: String?
    private var countdownImage: String?
    
    private var sponsorsData: [Sponsor] = []
    
    weak var delegate: HomeDelegate?
    
    private var firebaseReference: DatabaseReference?
    private var addHandle: DatabaseHandle?
    private var changeHandle: DatabaseHandle?
    private var deleteHandle: DatabaseHandle?
    private var countdownAddHandle: DatabaseHandle?
    private var countdownChangeHandle: DatabaseHandle?
    private var countdownDeleteHandle: DatabaseHandle?
    private var sponsorsAddHandle: DatabaseHandle?
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupFirebase()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = "Home"
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        setUpNavigation(controller: self.navigationController, hidesBar: false)
        Analytics.logEvent("Home_Screen_Did_Appear", parameters: nil)
    }
    
    func setupTableView() {
        tableView.allowsSelection = false
        tableView.backgroundColor = Theme.Color.white
        tableView.separatorStyle = .none
    }
    
    // MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if let countdownCell = tableView.dequeueReusableCell(withIdentifier: CountdownTableViewCell.identifier, for: indexPath) as? CountdownTableViewCell {
                countdownCell.configureCell(with: countdownDate, title: countdownTitle, image: countdownImage)
                if cellHeights[indexPath.row] == 0 {
                    cellHeights[indexPath.row] = countdownCell.sizeThatFits(CGSize(width: tableView.bounds.width - 40.0, height: .greatestFiniteMagnitude)).height
                }
                return countdownCell
            }
        case 1:
            if let announcementsTitleCell = tableView.dequeueReusableCell(withIdentifier: AnnouncementsTitleTableViewCell.identifier, for: indexPath) as? AnnouncementsTitleTableViewCell {
                return announcementsTitleCell
            }
        case 2:
            if let announcementCell = tableView.dequeueReusableCell(withIdentifier: AnnouncementTableViewCell.identifier, for: indexPath) as? AnnouncementTableViewCell {
                announcementCell.configureCell(with: announcementData[indexPath.row])
                return announcementCell
            }
        case 3:
            if let sponsorsCell = tableView.dequeueReusableCell(withIdentifier: SponsorsTableViewCell.identifier, for: indexPath) as? SponsorsTableViewCell {
                sponsorsCell.configureCell(with: sponsorsData)
                sponsorsCell.delegate = self
                return sponsorsCell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return announcementData.count
        } else {
            return 1
        }
    }
    
    // MARK: - Firebase
    
    func setupFirebase() {
        setupAnnouncementsReference()
        setupCountdownReference()
        setupSponsorsReference()
    }
    
    func setupAnnouncementsReference() {
        firebaseReference = Database.database().reference()
        addHandle = firebaseReference?.child("announcements").observe(.childAdded, with: { (snapshot) in
            guard let data = snapshot.value as? [String : AnyObject] else { return }
            let announcement = Announcement(JSON: data)
            
            if let id = announcement?.id, let announcement = announcement {
                self.announcementMap[id] = announcement
                self.announcementData.append(announcement)
            }
            self.tableView.reloadData()
            self.delegate?.tableDidLoad()
        })
        
        changeHandle = firebaseReference?.child("announcements").observe(.childChanged, with: { (snapshot) in
            guard let data = snapshot.value as? [String : AnyObject] else { return }
            let announcement = Announcement(JSON: data)
            
            if let id = announcement?.id, let announcement = announcement {
                self.announcementMap.updateValue(announcement, forKey: id)
                self.announcementData = Array(self.announcementMap.values)
            }
            self.tableView.reloadData()
        })
        
        deleteHandle = firebaseReference?.child("announcements").observe(.childRemoved, with: { (snapshot) in
            guard let data = snapshot.value as? [String : AnyObject] else { return }
            let announcement = Announcement(JSON: data)
            
            if let id = announcement?.id {
                self.announcementMap.removeValue(forKey: id)
                self.announcementData = Array(self.announcementMap.values)
            }
            self.tableView.reloadData()
        })
    }
    
    func setupCountdownReference() {
        firebaseReference = Database.database().reference()
        countdownAddHandle = firebaseReference?.child("countdown").observe(.childAdded, with: { (snapshot) in
            guard let data = snapshot.value as? [String : String] else { return }
            self.countdownTitle = data["title"]
            self.countdownImage = data["image"]
            let dateString = data["date"]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            self.countdownDate = dateFormatter.date(from: dateString ?? "")
            self.tableView.reloadData()
            self.delegate?.tableDidLoad()
        })

        countdownChangeHandle = firebaseReference?.child("countdown").observe(.childChanged, with: { (snapshot) in
            guard let data = snapshot.value as? [String : String] else { return }
            self.countdownTitle = data["title"]
            self.countdownImage = data["image"]
            let dateString = data["date"]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            self.countdownDate = dateFormatter.date(from: dateString ?? "")
            self.tableView.reloadData()

        })
    }
    
    func setupSponsorsReference() {
        firebaseReference = Database.database().reference()
        sponsorsAddHandle = firebaseReference?.child("sponsors").observe(.childAdded, with: { (snapshot) in
            guard let data = snapshot.value as? [String : AnyObject] else { return }
            guard let sponsor = Sponsor(JSON: data) else { return }
            self.sponsorsData.append(sponsor)
            self.tableView.reloadData()
            self.delegate?.tableDidLoad()
        })
    }

}

// MARK: - SponsorDelegate

extension HomeViewController: SponsorDelegate {
    
    func didSelectSponsor(item: Sponsor) {
        guard let url = URL(string: item.link ?? "") else { return }
        let svc = SFSafariViewController(url: url)
        svc.preferredControlTintColor = Theme.Color.main
        self.present(svc, animated: true, completion: nil)
    }
    
}
