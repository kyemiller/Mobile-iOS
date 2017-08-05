//
//  NSAttributedString+HTML.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 8/2/17.
//  Copyright © 2017 DanceBlue. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    class func stringFromHtml(_ message: String) -> NSMutableAttributedString? {
        do {
            if let data = message.data(using: String.Encoding.utf16, allowLossyConversion: true) {
                let str = try NSMutableAttributedString(data: data,options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSForegroundColorAttributeName: Styles.black],documentAttributes: nil)
                str.addAttribute(NSFontAttributeName, value: Styles.blogBodyFont, range: NSMakeRange(0, str.length))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .left
                paragraphStyle.lineSpacing = 1.4
                
                str.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, str.length))
                
                
                return str
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
