//
//  DetailsTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/1/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    static let identifier = "DetailsCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    private var data: BCDetails?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(with data: BCDetails) {
        self.data = data
        guard let date = data.timestamp else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        
        titleLabel.text = data.title
        authorLabel.text = data.author
        dateLabel.text = "• \(formatter.string(from: date))"
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let adjustedHeight = 24.0 + dateLabel.frame.height + authorLabel.frame.height + titleLabel.sizeThatFits(CGSize(width: bounds.width - 40, height: size.height)).height
        return CGSize(width: bounds.width, height: adjustedHeight)
    }
    
}
