//
//  FAQsTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 10/25/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class FAQsTableViewCell: UITableViewCell {
    
    static let identifier = "FAQsCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var faqImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        faqImageView.layer.cornerRadius = 5.0
        faqImageView.clipsToBounds = true
        faqImageView.image = #imageLiteral(resourceName: "DanceBlueReveal.jpg")
        titleLabel.text = "FAQs"
    }
    
}
