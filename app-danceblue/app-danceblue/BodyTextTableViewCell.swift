//
//  BodyTextTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/1/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class BodyTextTableViewCell: UITableViewCell {

    static let identifier = "BodyTextCell"

    @IBOutlet weak var bodyTextLabel: UILabel!
    
    private var data: BCBodyText?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let adjustedHeight = 20.0 + bodyTextLabel.sizeThatFits(CGSize(width: bounds.width - 40, height: size.height)).height
        return CGSize(width: bounds.width, height: adjustedHeight)
    }
    
    func configureCell(with data: BCBodyText) {
        self.data = data
        setupViews()
    }
    
    func setupViews() {
        guard let text = data?.bodyText else { return }
        bodyTextLabel.attributedText = NSAttributedString.stringFromHtml(text)
    }
    
}
