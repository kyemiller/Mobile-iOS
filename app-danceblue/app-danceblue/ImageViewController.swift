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
    private var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        guard let istring = flyer else { return }
        guard let url = URL(string: istring) else { return }
        displayImageView.kf.setImage(with: url)
    }
    
    func setupViews(with image: String?) {
        flyer = image
    }
    
    // MARK: - Actions

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Taken from: medium.com/@qbo/dismiss-viewcontrollers-presented-modally-using-swipe-down-923cfa9d22f4
    
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizerState.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
}
