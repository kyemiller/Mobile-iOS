//
//  MarathonViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 1/31/18.
//  Copyright © 2018 DanceBlue. All rights reserved.
//

import FirebaseAnalytics
import FirebaseDatabase
import UIKit

class MarathonViewController: UITableViewController {

    fileprivate var firebaseReference: DatabaseReference?
    private var moraleCupAddHandle: DatabaseHandle?
    private var moraleCupChangeHandle: DatabaseHandle?
    private var moraleCupDeleteHandle: DatabaseHandle?

    private var moraleCupMap: [String : AnyObject] = [:]
    private var cellHeights: [[CGFloat]] = [[],[]]
    private var marathonData: [[Event]] = [[],[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
    
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    // MARK: - Firebase
    
    func setupFirebase() {
        
        firebaseReference = Database.database().reference()
        
        // This Week Handles
        
        moraleCupAddHandle = firebaseReference?.child("marathon").child("moraleCup").observe(.childAdded, with: { (snapshot) in
            guard let data = snapshot.value as? [String : AnyObject]  else { return }
            guard let event = Event(JSON: data) else { return }
//            self.thisWeekMap[event.id ?? ""] = event
//            self.eventData[0].append(event)
//            self.sortEvents(section: 0)
//            self.tableView.reloadData()
//            self.delegate?.tableDidLoad()
        })
        
        moraleCupChangeHandle = firebaseReference?.child("marathon").child("moraleCup").observe(.childChanged, with: { (snapshot) in
            guard let data = snapshot.value as? [String : AnyObject]  else { return }
//            guard let event = Event(JSON: data) else { return }
//            self.thisWeekMap.updateValue(event, forKey: event.id ?? "")
//            self.eventData[0] = Array(self.thisWeekMap.values)
//            self.sortEvents(section: 0)
//            self.tableView.reloadData()
        })
        
        moraleCupDeleteHandle = firebaseReference?.child("marathon").child("moraleCup").observe(.childRemoved, with: { (snapshot) in
            guard let data = snapshot.value as? [String : AnyObject]  else { return }
//            guard let event = Event(JSON: data) else { return }
//            self.thisWeekMap.removeValue(forKey: event.id ?? "")
//            self.eventData[0] = Array(self.thisWeekMap.values)
//            self.sortEvents(section: 0)
//            self.tableView.reloadData()
        })
    }
}
