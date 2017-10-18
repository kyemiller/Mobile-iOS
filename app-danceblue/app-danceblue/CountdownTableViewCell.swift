//
//  CountdownTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 10/13/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class CountdownTableViewCell: UITableViewCell {

    static let identifier = "CountdownCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    private var countdownTimer: Timer?
    private var countdownDate: Date? {
        didSet {
            setupCountdown()
            log.debug("Timer Started")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(with date: Date?, title: String?) {
        countdownDate = date
        titleLabel.text = title
    }
    
    func setupCountdown() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    func updateCountdown() {
        guard let countdownDate = countdownDate else { return }
        let components = Calendar.current.dateComponents([.day, .hour,.minute,.second], from: Date(), to: countdownDate)
        
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        if days <= 0, hours <= 0, minutes <= 0, seconds <= 0 {
            countdownTimer?.invalidate()
        } else {
            countdownLabel.text = "\(days) Days | \(hours) Hours | \(minutes) Minutes | \(seconds) Seconds"
        }
    }
    
}
