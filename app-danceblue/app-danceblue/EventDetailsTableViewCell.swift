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
    
    @IBOutlet weak var spiritPointWordsLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var spiritPointsView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    private var event: Event?
    
    override func awakeFromNib() {
        underlineView.backgroundColor = Theme.Color.background
        spiritPointsView.backgroundColor = Theme.Color.lightGray
        spiritPointsView.layer.cornerRadius = spiritPointsView.frame.size.width / 2
        spiritPointsView.clipsToBounds = true
    }
    
    func configureCell(with event: Event) {
        self.event = event
        guard let date = event.timestamp else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        
        dateLabel.text = formatter.string(from: date)
        titleLabel.text = event.title
        timeLabel.text = "• \(event.time ?? "")"
        pointsLabel.text = event.points ?? ""
        spiritPointWordsLabel.text = event.points == "1" ? "Spirit Point" : "Spirit Points"
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var adjustedHeight = 24.0 + dateLabel.frame.height + titleLabel.sizeThatFits(CGSize(width: size.width - 28 - spiritPointsView.frame.width, height: size.height)).height
        if adjustedHeight < (spiritPointsView.frame.height + 20) {
            adjustedHeight = spiritPointsView.frame.height + 20
            
        }
        return CGSize(width: bounds.width, height: adjustedHeight)
    }
    
}
