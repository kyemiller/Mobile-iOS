//
//  ImageViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 11/13/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Kingfisher
import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var displayImageView: UIImageView!
    
    private var flyer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let istring = flyer else { return }
        guard let url = URL(string: istring) else { return }
        displayImageView.kf.setImage(with: url)
    }
    
    func setupViews(with image: String?) {
        flyer = image
    }

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
