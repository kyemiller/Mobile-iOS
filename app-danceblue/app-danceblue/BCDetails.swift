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
    
    var dataArray: [Any]? {
        didSet {
            guard let array = dataArray else { return }
            if array.count > 2 {
                title = array[0] as? String
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                
                if let dateString = array[1] as? String, let date = dateFormatter.date(from: dateString) {
                    timestamp = date
                }
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
