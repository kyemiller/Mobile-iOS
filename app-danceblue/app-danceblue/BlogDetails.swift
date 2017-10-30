//
//  BlogDetails.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/2/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import FirebaseStorage
import Foundation
import ObjectMapper
import UIKit

protocol BlogDetailsDelegate: class {
    func blog(didFinishDownloading image: UIImage)
}

class BlogDetails: Mappable {
    
    weak var delegate: BlogDetailsDelegate?
    
    var author: String?
    var title: String?
    var timestamp: Date?
    var imageString: String? {
        didSet {
            downloadImageFromFirebase()
        }
    }
    var image: UIImage?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        author <- map["author"]
        title <- map["title"]
        imageString <- map["image"]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let dateString = map["timestamp"].currentValue as? String, let date = dateFormatter.date(from: dateString) {
            timestamp = date
        }
    }
 
    func downloadImageFromFirebase() {
        let storage = Storage.storage()
        guard let url = self.imageString else { return }
        let gsReference = storage.reference(forURL: url)
        
        gsReference.getData(maxSize: 2 * 1024 * 1024) { data, error in
            if let error = error {
                log.debug("Error: \(error.localizedDescription)")
            } else {
                log.debug("Image downloaded.")
                self.image = UIImage(data: data!)
                self.delegate?.blog(didFinishDownloading: self.image!)
            }
        }
    }
}
