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
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventTime: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell() {
        
    }
    
    
    
}
