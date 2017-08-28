//
//  NavigationHelper.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/25/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Foundation
import UIKit

func setUpNavigation(controller: UINavigationController?) {
    guard let navigation = controller?.navigationBar else { return }
    controller?.hidesBarsOnTap = true
    controller?.hidesBarsOnSwipe = true
    navigation.tintColor = Theme.Color.black
    navigation.titleTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 18, weight: UIFontWeightHeavy), NSForegroundColorAttributeName : Theme.Color.black]
    navigation.isTranslucent = true
    navigation.barTintColor = Theme.Color.white
}
