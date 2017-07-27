//
//  EventsHeaderView.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/26/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit

class EventsHeaderView: UIView {

    let titleLabel = UILabel()
    
    public dynamic var sideMargin: CGFloat = 20.0
    public dynamic var labelHeight: CGFloat = 24.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Styles.mainColor
        titleLabel.text = "title"
        alpha = 0.9
        setupLabel()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureContent(title: String) {
        titleLabel.text = title
    }
    
    func setupLabel() {
        addSubview(titleLabel)
        
        titleLabel.textColor = Styles.white
        titleLabel.frame.size.width = bounds.width - (2 * sideMargin)
        titleLabel.frame.size.height = labelHeight
        titleLabel.font = .boldSystemFont(ofSize: 18.0)
        titleLabel.frame.origin.x = 20.0
        titleLabel.frame.origin.y = (bounds.height - titleLabel.frame.height) / 2
    }

}
