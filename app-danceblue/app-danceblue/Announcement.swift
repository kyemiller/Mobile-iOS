//
//  Announcement.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/23/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import ObjectMapper
import UIKit

class Announcement: Mappable {
    
    public var text: String?
    public var id: String?
    public var timestamp: Date?
    public var image: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        text <- map["text"]
        id <- map["id"]
        image <- map["image"]
        timestamp <- map["timestamp"]
    }

}
