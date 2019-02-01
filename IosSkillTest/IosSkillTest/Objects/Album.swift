//
//  Album.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 31/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import Foundation

class Album {
    var albumId: Int?
    var title: String?
    var thumbNail: String?
    var id: Int?
    var url: String?
    
    init(albumId: Int, title: String, thumbNail: String, id: Int, url: String) {
        self.albumId = albumId
        self.title = title
        self.thumbNail = thumbNail
        self.id = id
        self.url = url
    }
}
