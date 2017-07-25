//
//  MoreViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import TwitterKit

class MoreViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigation()
        
        if let videoURL = URL(string: "https://www.youtube.com/watch?v=RmHqOSrkZnk"){
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true, completion: nil)
            playerViewController.player?.play()
        }
        
    }
    
    func setUpNavigation() {
        guard let navigation = self.navigationController?.navigationBar else { return }
        
        self.title = "More"
        navigation.tintColor = Styles.mainColor
        navigation.isTranslucent = true
        navigation.barTintColor = Styles.white
        navigation.titleTextAttributes = [NSForegroundColorAttributeName : Styles.mainColor]
    }
    
    


}
