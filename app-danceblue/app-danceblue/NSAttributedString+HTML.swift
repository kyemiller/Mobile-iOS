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
                let str = try NSMutableAttributedString(data: data,options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSForegroundColorAttributeName: Theme.Color.black],documentAttributes: nil)
                str.addAttribute(NSFontAttributeName, value: Theme.Font.blog, range: NSMakeRange(0, str.length))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .left
                paragraphStyle.lineSpacing = 6.0
                
                str.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, str.length))
                
                
                return str
            }
        } catch {
            log.debug("\(error)")
        }
        return nil
    }
    
}
