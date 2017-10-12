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
import ObjectMapper

protocol AnnouncementCollectionViewDelegate: class {
    func collectionViewDidLoad()
}

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    private var firebaseReference: DatabaseReference?
    private var addHandle: DatabaseHandle?
    private var changeHandle: DatabaseHandle?
    private var deleteHandle: DatabaseHandle?
    private var countdownAddHandle: DatabaseHandle?
    private var countdownChangeHandle: DatabaseHandle?
    private var countdownDeleteHandle: DatabaseHandle?
    
    private var announcementData: [Announcement] = []
    private var announcementMap: [String : Announcement] = [:]
    
    private var countdownTimer: Timer?
    private var countdownDate: Date? {
        didSet {
            setupCountdown()
        }
    }
    
    weak var delegate: AnnouncementCollectionViewDelegate?
    
    @IBOutlet weak var announcementsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpNavigation(controller: navigationController, hidesBar: false)
        self.title = "Announcements"
    }
    
    func setupCountdown() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    func updateCountdown() {
        guard let countdownDate = countdownDate else { return }
        let components = Calendar.current.dateComponents([.day, .hour,.minute,.second], from: Date(), to: countdownDate)
        
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        if days <= 0, hours <= 0, minutes <= 0, seconds <= 0 {
            countdownTimer?.invalidate()
        } else {
            timeLeftLabel.text = "\(days) Days | \(hours) Hours | \(minutes) Minutes | \(seconds) Seconds"
        }
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        announcementsCollectionView.collectionViewLayout = layout
        
        announcementsCollectionView.delegate = self
        announcementsCollectionView.dataSource = self
        announcementsCollectionView.isPagingEnabled = true
    }
    
    // MARK: - Firebase
    
    func setupFirebase() {
        setupAnnouncementsReference()
        setupCountdownReference()
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
            self.announcementsCollectionView.reloadData()
            self.delegate?.collectionViewDidLoad()
        })
        
        
        changeHandle = firebaseReference?.child("announcements").observe(.childChanged, with: { (snapshot) in
            guard let data = snapshot.value as? [String : AnyObject] else { return }
            let announcement = Announcement(JSON: data)
            
            if let id = announcement?.id, let announcement = announcement {
                self.announcementMap.updateValue(announcement, forKey: id)
                self.announcementData = Array(self.announcementMap.values)
            }
        })
        
        deleteHandle = firebaseReference?.child("announcements").observe(.childRemoved, with: { (snapshot) in
            guard let data = snapshot.value as? [String : AnyObject] else { return }
            let announcement = Announcement(JSON: data)
            
            if let id = announcement?.id {
                self.announcementMap.removeValue(forKey: id)
                self.announcementData = Array(self.announcementMap.values)
            }
        })
    }
    
    func setupCountdownReference() {
        firebaseReference = Database.database().reference()
        countdownAddHandle = firebaseReference?.child("countdown").observe(.childAdded, with: { (snapshot) in
            log.debug(snapshot.value)
            guard let data = snapshot.value as? [String : String] else { return }
            self.countdownLabel.text = data["title"]
            let dateString = data["date"]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            self.countdownDate = dateFormatter.date(from: dateString ?? "")
        })
        
        
        countdownChangeHandle = firebaseReference?.child("countdown").observe(.childChanged, with: { (snapshot) in
            guard let data = snapshot.value as? [String : String] else { return }
            self.countdownLabel.text = data["title"]
            let dateString = data["date"]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            self.countdownDate = dateFormatter.date(from: dateString ?? "")
            
        })
    
    }
    
    // MARK: - CollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return announcementData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnnouncementCollectionViewCell.identifier, for: indexPath) as? AnnouncementCollectionViewCell {
            cell.configureCell(with: announcementData[indexPath.row], for: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }

}
