//
//  HomeViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import TwitterKit
import Firebase
import FirebaseDatabase

protocol AnnouncementsTableViewDelegate: class {
    func tableDidLoad()
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var twitterContainerView: UIView!
    @IBOutlet weak var announcementsTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    private var firebaseReference: DatabaseReference?
    private var addHandle: DatabaseHandle?
    private var changeHandle: DatabaseHandle?
    private var deleteHandle: DatabaseHandle?
    
    private var announcementData: [Announcement] = []
    private var announcementMap: [String : Announcement] = [:]
    
    weak var delegate: AnnouncementsTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        announcementsTableView.delegate = self
        announcementsTableView.dataSource = self
        setupViews()
        setupFirebase()
        
    }
    
    
    func setupViews() {
        setUpNavigation()
        setupSegmentedControl()
        twitterContainerView.isHidden = true
        announcementsTableView.isHidden = false
        headerView.isHidden = false
        
    }
    
    func setUpNavigation() {
        guard let navigation = self.navigationController?.navigationBar else { return }
        
        self.title = "Home"
        navigation.tintColor = Styles.mainColor
        navigation.shadowImage = UIImage()
        navigation.setBackgroundImage(UIImage(), for: .default)
        navigation.isTranslucent = true
        navigation.barTintColor = Styles.white
        navigation.titleTextAttributes = [NSForegroundColorAttributeName : Styles.mainColor]
    }
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
=======
>>>>>>> Stashed changes
    
    func setupSegmentedControl() {
        segmentedControl.tintColor = Styles.segmentControllerTintColor
        segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName:Styles.mainColor], for: .selected)
    }
    
    @IBAction func didChangeSegmentedControl(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            twitterContainerView.isHidden = true
            announcementsTableView.isHidden = false
            headerView.isHidden = false
        } else {
            twitterContainerView.isHidden = false
            announcementsTableView.isHidden = true
            headerView.isHidden = true
        }
    }
    
    func setupFirebase() {
        firebaseReference = Database.database().reference()
        
        addHandle = firebaseReference?.child("announcements").observe(.childAdded, with: { (snapshot) in
<<<<<<< Updated upstream
            print("here")
=======
>>>>>>> Stashed changes
            print(snapshot.value!)
            let announcement = Announcement(from: snapshot.value as! [String : AnyObject])
            self.announcementMap[announcement.id!] = announcement
            self.announcementData.append(announcement)
            self.announcementsTableView.reloadData()
<<<<<<< Updated upstream
            print("HERE")
=======
>>>>>>> Stashed changes
            self.delegate?.tableDidLoad()
        })
        
        
        changeHandle = firebaseReference?.child("announcements").observe(.childChanged, with: { (snapshot) in
<<<<<<< Updated upstream
            print("here1")
=======
>>>>>>> Stashed changes
            print(snapshot.value!)
            let announcement = Announcement(from: snapshot.value as! [String : AnyObject])
            print(announcement)
            self.announcementMap.updateValue(announcement, forKey: announcement.id!)
            self.announcementData = Array(self.announcementMap.values)
            self.announcementsTableView.reloadData()
        })
        
        deleteHandle = firebaseReference?.child("announcements").observe(.childRemoved, with: { (snapshot) in
<<<<<<< Updated upstream
            print("here2")
=======
>>>>>>> Stashed changes
            print(snapshot.value!)
            let announcement = Announcement(from: snapshot.value as! [String : AnyObject])
            print(announcement)
            self.announcementMap.removeValue(forKey: announcement.id!)
            self.announcementData = Array(self.announcementMap.values)
            self.announcementsTableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AnnouncementTableViewCell.identifier, for: indexPath) as? AnnouncementTableViewCell {
            cell.configureCell(with: announcementData[indexPath.row], for: indexPath)
            return cell
        }
        return AnnouncementTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementData.count
    }
<<<<<<< Updated upstream
=======
>>>>>>> Stashed changes
>>>>>>> Stashed changes

}

