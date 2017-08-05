//
//  Event.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

protocol EventDelegate: class {
    func event(didFinishDownloadingImage image: UIImage)
}

class Event {
    
    public var month: String?
    public var date: Int?
    public var title: String?
    public var location: String?
    public var time: String?
    public var id: String?
    public var timestamp: Date?
    public var address: String?
    public var imageString: String?
    public var image: UIImage? 

    weak var delegate: EventDelegate?
    
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
        imageString = dictionary["image"] as? String
        downloadImageFromFirebase()
    }
    
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
=======
>>>>>>> Stashed changes
    func downloadImageFromFirebase() {
        let storage = Storage.storage()
        guard let url = self.imageString else { return }
        let gsReference = storage.reference(forURL: url)
        
        gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
<<<<<<< Updated upstream
                // Uh-oh, an error occurred!
                log.debug("Error: \(error.localizedDescription)")
            } else {
=======
                log.debug("Error: \(error.localizedDescription)")
            } else {
                log.debug("Image downloaded.")
>>>>>>> Stashed changes
                self.image = UIImage(data: data!)
                self.delegate?.event(didFinishDownloadingImage: self.image!)
            }
        }
    }
<<<<<<< Updated upstream
=======
>>>>>>> Stashed changes
>>>>>>> Stashed changes
}
