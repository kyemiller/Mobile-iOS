//
//  EventsViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EventsViewController: UITableViewController {

    // TODO: Fix all force unwraps and make code safer!
    
    private var firebaseReference: DatabaseReference?
    private var addHandle: DatabaseHandle?
    private var changeHandle: DatabaseHandle?
    private var deleteHandle: DatabaseHandle?
    
    private var eventMap: [String : Event] = [:]
    private var eventData: [Event] = []
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupFirebase()
    }
    
    func setupNavigation() {
        guard let navigation = self.navigationController?.navigationBar else { return }
        
        self.title = "Events"
        navigation.tintColor = Styles.mainColor
        navigation.isTranslucent = true
        navigation.barTintColor = Styles.white
        navigation.titleTextAttributes = [NSForegroundColorAttributeName : Styles.mainColor]
    }
    
    func setupFirebase() {
        firebaseReference = Database.database().reference()
        
        addHandle = firebaseReference?.child("events").observe(.childAdded, with: { (snapshot) in
            print("here")
            print(snapshot.value!)
            let event = Event(from: snapshot.value as! [String : AnyObject])
            print(event)
            self.eventMap[event.id!] = event
            self.eventData.append(event)
            self.sortEvents()
            self.tableView.reloadData()
        })
        
        changeHandle = firebaseReference?.child("events").observe(.childChanged, with: { (snapshot) in
            print("here1")
            print(snapshot.value!)
            let event = Event(from: snapshot.value as! [String : AnyObject])
            print(event)
            self.eventMap.updateValue(event, forKey: event.id!)
            self.eventData = Array(self.eventMap.values)
            self.sortEvents()
            self.tableView.reloadData()
        })
        
        deleteHandle = firebaseReference?.child("events").observe(.childRemoved, with: { (snapshot) in
            print("here2")
            print(snapshot.value!)
            let event = Event(from: snapshot.value as! [String : AnyObject])
            print(event)
            self.eventMap.removeValue(forKey: event.id!)
            self.eventData = Array(self.eventMap.values)
            self.sortEvents()

            self.tableView.reloadData()
        })
    }

    // MARK: - Tableview
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell {
            cell.configureCell(with: eventData[indexPath.row], for: indexPath)
            return cell
        }
        return EventTableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventData.count
    }
    
    // MARK: - Utility 
    
    func sortEvents() {
        eventData.sort(by: {$0.timestamp! < $1.timestamp!})
    }
}
