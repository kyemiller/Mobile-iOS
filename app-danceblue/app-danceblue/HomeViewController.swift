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
    
    
    private var firebaseReference: DatabaseReference?
    private var addHandle: DatabaseHandle?
    private var changeHandle: DatabaseHandle?
    private var deleteHandle: DatabaseHandle?
    
    private var announcementData: [Announcement] = []
    private var announcementMap: [String : Announcement] = [:]
    
    weak var delegate: AnnouncementCollectionViewDelegate?
    
    @IBOutlet weak var announcementsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        setupCollectionView()
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        setUpNavigation()
    }
    
    func setUpNavigation() {
        guard let navigation = self.navigationController?.navigationBar else { return }
        
        self.title = "Home"
        navigation.tintColor = Styles.black
        navigation.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Helvetica-Bold", size: 24.0) ?? UIFont(), NSForegroundColorAttributeName : Styles.black]
        navigation.isTranslucent = true
        navigation.barTintColor = Styles.white
    }
    


    
    func setupFirebase() {
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

