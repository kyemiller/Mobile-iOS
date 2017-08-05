//
//  EventsTableViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

protocol EventsTableViewDelegate: class {
    func tableDidLoad()
}

class EventsTableViewController: UITableViewController {

    // TODO: Fix all force unwraps and make code safer!
    
    private var firebaseReference: DatabaseReference?
    private var thisWeekAddHandle: DatabaseHandle?
    private var comingUpAddHandle: DatabaseHandle?
    private var thisWeekchangeHandle: DatabaseHandle?
    private var comingUpChangeHandle: DatabaseHandle?
    private var thisWeekDeleteHandle: DatabaseHandle?
    private var comingUpDeleteHandle: DatabaseHandle?
    
    weak var delegate: EventsTableViewDelegate?
    private var thisWeekMap: [String : Event] = [:]
    private var comingUpMap: [String : Event] = [:]
    private var eventData: [[Event]] = [[],[]]
    private var sectionData: [String] = ["This Week", "Coming Up"]
    let eventDetailsSegueIdentifier = "EventDetailsSegue"
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupFirebase()
    }
    
    func setupTableView() {
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = Styles.tableViewColor
    }


    // MARK: - Tableview
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell {
            cell.configureCell(with: eventData[indexPath.section][indexPath.row], for: indexPath)
            return cell
        }
        return EventTableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return eventData[0].count
        } else {
            return eventData[1].count
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = EventsHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 30.0))
        header.configureContent(title: sectionData[section])
        return header
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }

    // MARK: - Storyboard
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let eventDetailsViewController = segue.destination as? EventDetailsViewController, segue.identifier == eventDetailsSegueIdentifier, let section = tableView.indexPathForSelectedRow?.section, let row = tableView.indexPathForSelectedRow?.row {
            eventDetailsViewController.event = eventData[section][row]
        }
        
    }
    
    // MARK: - Utility 
    
    func sortEvents(section: Int) {
        eventData[section].sort(by: {$0.timestamp ?? Date() < $1.timestamp ?? Date()})
    }
    
    // MARK: - Firebase
    
    func setupFirebase() {
        
        firebaseReference = Database.database().reference()
        
        // This Week Handles
        
        thisWeekAddHandle = firebaseReference?.child("events").child("thisWeek").observe(.childAdded, with: { (snapshot) in
            let event = Event(from: snapshot.value as! [String : AnyObject])
            print(snapshot.value!)
            self.thisWeekMap[event.id!] = event
            self.eventData[0].append(event)
            self.sortEvents(section: 0)
            self.tableView.reloadData()
            self.delegate?.tableDidLoad()
        })
        
        thisWeekchangeHandle = firebaseReference?.child("events").child("thisWeek").observe(.childChanged, with: { (snapshot) in
            let event = Event(from: snapshot.value as! [String : AnyObject])
            self.thisWeekMap.updateValue(event, forKey: event.id!)
            self.eventData[0] = Array(self.thisWeekMap.values)
            self.sortEvents(section: 0)
            self.tableView.reloadData()
        })
        
        thisWeekDeleteHandle = firebaseReference?.child("events").child("thisWeek").observe(.childRemoved, with: { (snapshot) in
            let event = Event(from: snapshot.value as! [String : AnyObject])
            self.thisWeekMap.removeValue(forKey: event.id!)
            self.eventData[0] = Array(self.thisWeekMap.values)
            self.sortEvents(section: 0)
            self.tableView.reloadData()
        })
        
        // Coming Up Handles
        
        comingUpAddHandle = firebaseReference?.child("events").child("comingUp").observe(.childAdded, with: { (snapshot) in
            let event = Event(from: snapshot.value as! [String : AnyObject])
            self.comingUpMap[event.id!] = event
            self.eventData[1].append(event)
            self.sortEvents(section: 1)
            self.tableView.reloadData()
            self.delegate?.tableDidLoad()
        })
        
        comingUpChangeHandle = firebaseReference?.child("events").child("comingUp").observe(.childChanged, with: { (snapshot) in
            let event = Event(from: snapshot.value as! [String : AnyObject])
            self.comingUpMap.updateValue(event, forKey: event.id!)
            self.eventData[1] = Array(self.comingUpMap.values)
            self.sortEvents(section: 1)
            self.tableView.reloadData()
        })
        
        comingUpDeleteHandle = firebaseReference?.child("events").child("comingUp").observe(.childRemoved, with: { (snapshot) in
            let event = Event(from: snapshot.value as! [String : AnyObject])
            self.comingUpMap.removeValue(forKey: event.id!)
            self.eventData[1] = Array(self.comingUpMap.values)
            self.sortEvents(section: 1)
            self.tableView.reloadData()
        })
    }
}
