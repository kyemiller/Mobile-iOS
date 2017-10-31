//
//  BCBodyImage.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/2/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit

class BCBodyImage: Mappable {
    
    var image: String?
    var description: String?
    var isGif: Bool? = false
    var data: Data?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        image <- map["image"]
        isGif <- map["isGif"]
        description <- map ["description"]
    }

    
}
