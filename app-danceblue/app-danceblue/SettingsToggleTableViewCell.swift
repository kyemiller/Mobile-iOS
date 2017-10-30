//
//  SettingsToggleTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 10/26/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import UserNotifications

enum Settings {
    case notifications
}

class SettingsToggleTableViewCell: UITableViewCell {

    static let identifier = "SettingsToggleCell"
    
    @IBOutlet weak var settingsSwitch: UISwitch!
    @IBOutlet weak var settingsLabel: UILabel!
    
    private var settings: Settings?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingsLabel.font = Theme.Font.blog
        settingsSwitch.tintColor = Theme.Color.main
    }
    
    func configureCell(with settings: Settings) {
        self.settings = settings
    }
    
    func setupNotifications() {
        if settings == .notifications {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                if (settings.authorizationStatus == .authorized) {
                    self.settingsSwitch.setOn(true, animated: false)
                } else {
                    self.settingsSwitch.setOn(false, animated: false)
                }
            }
        }
    }
    
    func toggleNotifications() {
        if settings == .notifications {
            UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings) in
                if settings.authorizationStatus == .authorized {
                    
                } else {
                    
                }
            })
        }
    }
    
    @IBAction func didToggleSwitch(_ sender: Any) {

        if settingsSwitch.isOn {
            settingsSwitch.setOn(false, animated: true)
        } else {
            settingsSwitch.setOn(true, animated: true)
        }
    }
    
}
