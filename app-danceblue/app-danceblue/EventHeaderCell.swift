//
//  EventHeaderCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 9/18/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Kingfisher
import UIKit

class EventHeaderCell: UITableViewCell {
    
    static let identifier = "EventHeaderCell"
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    fileprivate var event: Event?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        headerImageView.clipsToBounds = true
        headerImageView.backgroundColor = Theme.Color.background
    }
    
    func configureCell(with event: Event) {
        self.event = event
        headerImageView.kf.setImage(with: URL(string: event.image ?? ""))
    }
    
    // MARK: - Layout
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let header = headerImageView else { return CGSize() }
        let height: CGFloat = header.frame.height + 8.0
        return CGSize(width: bounds.width, height: height)
    }

}

