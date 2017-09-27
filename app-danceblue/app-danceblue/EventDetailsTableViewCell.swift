//
//  EventDescriptionTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 9/19/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class EventDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "EventDetailsCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    private var event: Event?
    
    func configureCell(with event: Event) {
        self.event = event
        guard let date = event.timestamp else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        dateLabel.text = formatter.string(from: date)
        
        titleLabel.text = event.title
        timeLabel.text = "• \(event.time ?? "")"
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let adjustedHeight = 24.0 + dateLabel.frame.height + titleLabel.sizeThatFits(CGSize(width: size.width - 40, height: size.height)).height
        return CGSize(width: bounds.width, height: adjustedHeight)
    }
    
}
