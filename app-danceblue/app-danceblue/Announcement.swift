//
//  Announcement.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/23/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Foundation

class Announcement {
    
    public var text: String?
    public var id: String?

    
    init(from dictionary: [String : AnyObject]) {
        
        text = dictionary["text"] as? String
        id = dictionary["id"] as? String

    }
    
}
