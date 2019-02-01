//
//  User.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 30/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var email     :String?
    @objc dynamic var name      :String?
    @objc dynamic var password  :String?
}
