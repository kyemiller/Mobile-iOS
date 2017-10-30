//
//  SettingsTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 10/26/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        settingsImageView.layer.cornerRadius = 5.0
        settingsImageView.clipsToBounds = true
        settingsImageView.image = #imageLiteral(resourceName: "Settings")
        titleLabel.text = "SETTINGS"
        titleLabel.font = Theme.Font.header
    }
    
}
