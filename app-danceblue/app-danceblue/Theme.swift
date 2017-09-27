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
        static let blog: UIFont = UIFont(name: "Palatino-Roman", size: 18.0)!
        static let title: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFontWeightHeavy)
        static let header: UIFont = UIFont.systemFont(ofSize: 20, weight: UIFontWeightHeavy)
    }
    
    // MARK: - Color
    
    struct Color {
        static let white: UIColor = .white
        static let black: UIColor = .black
        static let clear: UIColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        static let background: UIColor = UIColor(colorLiteralRed: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        static let loader: UIColor = UIColor(colorLiteralRed: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 0.7)
        static let main: UIColor = UIColor(colorLiteralRed: 16.0/255.0, green: 125.0/255.0, blue: 254.0/255.0, alpha: 1.0)
    }
    
}
