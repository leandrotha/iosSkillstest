//
//  StringExtesion.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 30/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        
        var emailRegex: NSRegularExpression?
        
        do {
            emailRegex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        } catch let error {
            print(error.localizedDescription)
        }
        
        guard let regex = emailRegex else {return false}
        
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func hexToColor(withAlpha: CGFloat = 1.0) -> UIColor {
        let range = NSRange(0..<6)
        let cString = self.trim().replacingOccurrences(of: "#", with: "").uppercased()[range]
        var rgbValue :UInt32 = 0
        
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: withAlpha
        )
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    subscript (r: NSRange) -> String {
        get {
            if let range = Range(r, in: self) {
                return String(self[range])
            }
            return ""
        }
    }
}
