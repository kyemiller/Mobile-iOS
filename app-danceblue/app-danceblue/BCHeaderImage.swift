//
//  BCHeaderImage.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/2/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Foundation
import FirebaseStorage
import ObjectMapper
import UIKit

protocol BlogDetailsHeaderImageDelegate: class {
    func headerImage(didFinishDownloading image: UIImage?)
}

class BCHeaderImage: Mappable {
    
    var image: UIImage?
    var description: String?
    var imageString: String? {
        didSet {
            downloadImageFromFirebase()
        }
    }
    
    weak var delegate: BlogDetailsHeaderImageDelegate?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        imageString <- map["image"]
        description <- map["description"]
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
                self.delegate?.headerImage(didFinishDownloading: self.image!)
            }
        }
    }
    
}
