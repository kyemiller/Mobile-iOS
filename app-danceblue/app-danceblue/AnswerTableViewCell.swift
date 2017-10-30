
//
//  AnswerTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 10/25/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    static let identifier = "AnswerCell"
    
    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        answerLabel.font = Theme.Font.blog
    }
    
    func configureCell(with data: [String : String]) {
        answerLabel.text = data["answer"]
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: 20.0 + answerLabel.sizeThatFits(CGSize(width: size.width, height: .greatestFiniteMagnitude)).height)
    }
    
}
