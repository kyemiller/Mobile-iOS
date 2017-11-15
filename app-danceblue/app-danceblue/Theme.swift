//
//  Theme.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 7/22/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    
    // MARK: - Font
    
    struct Font {
        static let body: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        static let title: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.heavy)
        static let header: UIFont = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
    }
    
    // MARK: - Color
    
    struct Color {
        static let white: UIColor = .white
        static let black: UIColor = .black
        static let lightGray: UIColor = .lightGray
        static let clear: UIColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        static let background: UIColor = UIColor(displayP3Red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        static let loader: UIColor = UIColor(displayP3Red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 0.7)
        static let main: UIColor = UIColor(displayP3Red: 16.0/255.0, green: 125.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        static let body: UIColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
    }
    
}
