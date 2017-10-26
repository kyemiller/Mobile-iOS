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

protocol HomeDelegate: class {
    func tableDidLoad()
}

class HomeViewController: UITableViewController {
    
    private var cellHeights: [CGFloat] = [75.0, 56.0, 120.0, 75.0, 240.0]
    
    private var announcementData: [Announcement] = []
    private var announcementMap: [String : Announcement] = [:]
    
    private var countdownDate: Date?
    private var countdownTitle: String?
    
    private var galleryData: [URL] = []
    
    weak var delegate: HomeDelegate?
    
    private var firebaseReference: DatabaseReference?
    private var addHandle: DatabaseHandle?
    private var changeHandle: DatabaseHandle?
    private var deleteHandle: DatabaseHandle?
    private var countdownAddHandle: DatabaseHandle?
    private var countdownChangeHandle: DatabaseHandle?
    private var countdownDeleteHandle: DatabaseHandle?
    private var galleryAddHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupFirebase()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = "Home"
        setUpNavigation(controller: self.navigationController, hidesBar: false)
        Analytics.logEvent("Home View Controller Did Appear.", parameters: nil)
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
                countdownCell.configureCell(with: countdownDate, title: countdownTitle)
                return countdownCell
            }
        case 4:
            if let galleryCell = tableView.dequeueReusableCell(withIdentifier: GalleryTableViewCell.identifier, for: indexPath) as? GalleryTableViewCell {
                galleryCell.configureCell(with: galleryData)
                return galleryCell
            }
        case 3:
            if let factsCell = tableView.dequeueReusableCell(withIdentifier: FactsTableViewCell.identifier, for: indexPath) as? FactsTableViewCell {
                return factsCell
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
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
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
        setupGalleryReference()
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
            let dateString = data["date"]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            self.countdownDate = dateFormatter.date(from: dateString ?? "")
            self.tableView.reloadData()

        })
    }
    
    func setupGalleryReference() {
        firebaseReference = Database.database().reference()
        galleryAddHandle = firebaseReference?.child("gallery").observe(.childAdded, with: { (snapshot) in
            guard let data = snapshot.value as? String else { return }
            guard let url = URL(string: data) else { return }
            self.galleryData.append(url)
            self.tableView.reloadData()
        })
    }

}
