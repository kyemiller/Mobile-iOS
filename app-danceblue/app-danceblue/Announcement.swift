//
//  Announcement.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/23/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Foundation
import FirebaseStorage
import ObjectMapper
import UIKit

protocol AnnouncementDelegate: class {
    func announcement(didFinishDownloadingImage image: UIImage)
}

class Announcement: Mappable {
    
    public var text: String?
    public var id: String?
    public var image: UIImage?
    public var timestamp: Date?
    public var imageString: String? {
        didSet {
            downloadImageFromFirebase()
        }
    }
    
    weak var delegate: AnnouncementDelegate?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        text <- map["text"]
        id <- map["id"]
        imageString <- map["image"]
        timestamp <- map["timestamp"]
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
                self.delegate?.announcement(didFinishDownloadingImage: self.image!)
            }
        }
    }
}
