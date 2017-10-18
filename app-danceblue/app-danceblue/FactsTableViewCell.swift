//
//  FactsTableViewCell.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 10/17/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class FactsTableViewCell: UITableViewCell {

    static let identifier = "FactsCell"
    
    private var cellData = [["Provided for the kids!", "Fact"],
                            ["Hours standing FTK", "288"],
                            ["Random Fact about the kids", "FTK!"]]
    
    private var factsTimer: Timer?
    private var iteration = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTimer()
    }

    func updateCell() {
        if iteration == cellData.endIndex - 1 {
            iteration = 0
        } else {
            iteration += 1
        }
        titleLabel.text = cellData[iteration][0]
        descriptionLabel.text = cellData[iteration][1]
    }
    
    func setupTimer() {
        factsTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(updateCell), userInfo: nil, repeats: true)
    }
}
