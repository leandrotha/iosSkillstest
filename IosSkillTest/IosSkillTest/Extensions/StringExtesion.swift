//
//  StringExtesion.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 30/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import Foundation

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
}
