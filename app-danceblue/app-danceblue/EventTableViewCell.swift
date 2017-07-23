//
//  EventTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    static let identifier = "EventCell"
    
    @IBOutlet weak var calendarBanner: UIView!
    @IBOutlet weak var calendarBackground: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!

    private var event: Event?
    
    // MARK: - Styling
    
    private var lightBackgroundColor: UIColor = Styles.eventsBackgroundColorLight
    private var darkBackgroundColor: UIColor = Styles.eventsBackgroundColorDark
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        calendarBanner.layer.cornerRadius = 5.0
        calendarBackground.layer.cornerRadius = 5.0
        
        calendarBanner.clipsToBounds = true
        calendarBackground.clipsToBounds = true
    }

    func configureCell(with event: Event, for indexPath: IndexPath) {
        monthLabel.text = event.month
        dateLabel.text = "\(event.date ?? 0)"
        eventTitleLabel.text = event.title
        eventLocationLabel.text = event.location
        eventTimeLabel.text = event.time
        
        self.backgroundColor = indexPath.row % 2 == 0 ? lightBackgroundColor : darkBackgroundColor
        
    }
    
    
    
}
