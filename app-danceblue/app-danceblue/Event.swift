//
//  Event.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Foundation

class Event {
    
    public var month: String?
    public var date: Int?
    public var title: String?
    public var location: String?
    public var time: String?
    public var id: String?
    public var timestamp: Date?
    public var address: String?
    
    init(from dictionary: [String : AnyObject]) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        month = dictionary["month"] as? String
        date = dictionary["date"] as? Int
        title = dictionary["title"] as? String
        location = dictionary["location"] as? String
        time = dictionary["time"] as? String
        id = dictionary["id"] as? String
        timestamp = dateFormatter.date(from: dictionary["timestamp"] as! String)
        address = dictionary["address"] as? String
    }
    
}
