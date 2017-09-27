//
//  BCBodyImage.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/2/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Foundation
import FirebaseStorage
import ObjectMapper
import UIKit

protocol BlogDetailsBodyImageDelegate: class {
    func bodyImage(didFinishDownloading image: UIImage?)
}

class BCBodyImage: Mappable {
    
    var imageString: String? {
        didSet {
            downloadImageFromFirebase()
        }
    }
    var image: UIImage?
    var description: String?
    var isGif: Bool? = false
    var data: Data?
    
    weak var delegate: BlogDetailsBodyImageDelegate?
    
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        imageString <- map["image"]
        isGif <- map["isGif"]
        description <- map ["description"]
    }
    
    func downloadImageFromFirebase() {
        let storage = Storage.storage()
        guard let url = self.imageString else { return }
        let gsReference = storage.reference(forURL: url)
        
        gsReference.getData(maxSize: 3 * 1024 * 1024) { data, error in
            if let error = error {
                log.debug("Error: \(error.localizedDescription)")
            } else {
                log.debug("Image downloaded.")
                self.data = data
                self.image = UIImage(data: data!)
                self.delegate?.bodyImage(didFinishDownloading: self.image!)
            }
        }
    }
    
}
