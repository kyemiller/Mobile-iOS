//
//  EventDescriptionCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 9/21/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Foundation
import UIKit

class EventDescriptionCell: UITableViewCell {
    
    static let identifier = "EventDescriptionCell"
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var event: Event?
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let adjustedHeight = 16.0 + descriptionLabel.sizeThatFits(CGSize(width: size.width - 40, height: size.height)).height
        return CGSize(width: bounds.width, height: adjustedHeight)
    }
    
    func configureCell(with event: Event) {
        self.event = event
        descriptionLabel.text = event.description ?? ""
    }
    
}
