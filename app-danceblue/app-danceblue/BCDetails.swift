//
//  BCDetails.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/2/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Foundation
import ObjectMapper

class BCDetails: Mappable {
    
    var dataArray: [AnyObject]? {
        didSet {
            guard let array = dataArray else { return }
            if array.count > 2 {
                title = array[0] as? String
                timestamp = array[1] as? Date
                author = array[2] as? String
            }
        }
    }
    
    var title: String?
    var timestamp: Date?
    var author: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        dataArray <- map["details"]
    }
    
}
