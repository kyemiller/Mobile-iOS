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
    
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    private var event: Event?
    
    override func awakeFromNib() {
        underlineView.backgroundColor = Theme.Color.main
        titleLabel.font = Theme.Font.header
        titleLabel.text = "DESCRIPTION"
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let adjustedHeight = 8.0 + titleLabel.frame.height + 2.0 +  underlineView.frame.height + 8.0 + descriptionLabel.sizeThatFits(CGSize(width: size.width - 40, height: size.height)).height + 16.0
        return CGSize(width: bounds.width, height: adjustedHeight)
    }
    
    func configureCell(with event: Event) {
        self.event = event
        descriptionLabel.text = event.description ?? ""
    }
    
}
