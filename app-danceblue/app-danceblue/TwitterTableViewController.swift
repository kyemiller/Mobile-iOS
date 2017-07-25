//
//  TwitterTableViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/23/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import UIKit
import TwitterKit
import XCGLogger

class TwitterTableViewController: TWTRTimelineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let client = TWTRAPIClient()
        self.dataSource = TWTRUserTimelineDataSource(screenName: "UKDanceBlue", apiClient: client)
        self.showTweetActions = false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(fileURLWithPath: "twitter://user?screen_name=UKDanceBlue")
        UIApplication.shared.open(url, options: [:]) { completion in
            log.debug("Opened Twitter")
        }
    }


}
