//
//  Event.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import FirebaseStorage
import Foundation
import ObjectMapper
import UIKit

protocol EventDelegate: class {
    func event(didFinishDownloadingImage image: UIImage)
    func event(didFinishDownloadingMap map: UIImage)
}

class Event: Mappable {
    
    public var month: String?
    public var points: String?
    public var date: Int?
    public var title: String?
    public var description: String?
    public var time: String?
    public var id: String?
    public var timestamp: Date?
    public var address: String?
    public var map: UIImage?
    public var image: UIImage?
    
    public var mapString: String? {
        didSet {
            downloadMapFromFirebase()
        }
    }
    
    public var imageString: String? {
        didSet {
            downloadImageFromFirebase()
        }
    }

    weak var delegate: EventDelegate?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        month <- map["month"]
        date <- map["date"]
        title <- map["title"]
        time <- map["time"]
        id <- map["id"]
        address <- map["address"]
        imageString <- map["image"]
        mapString <- map["map"]
        points <- map["points"]
        description <- map ["description"]
        
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
                self.delegate?.event(didFinishDownloadingImage: self.image!)
            }
        }
    }
    
    func downloadMapFromFirebase() {
        let storage = Storage.storage()
        guard let url = self.mapString else { return }
        let gsReference = storage.reference(forURL: url)
        
        gsReference.getData(maxSize: 2 * 1024 * 1024) { data, error in
            if let error = error {
                log.debug("Error: \(error.localizedDescription)")
            } else {
                log.debug("Map downloaded.")
                self.map = UIImage(data: data!)
                self.delegate?.event(didFinishDownloadingMap: UIImage(data: data!)!)
            }
        }
    }

}
