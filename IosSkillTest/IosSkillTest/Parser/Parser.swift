//
//  Parser.swift
//  IosSkillTest
//
//  Created by Leandro Bartsch Thá on 31/01/19.
//  Copyright © 2019 Leandro Bartsch Thá. All rights reserved.
//

import Foundation

class Parser {
    static func parseAlbum(_ data: Data?) throws -> [Album] {
        guard let jsonData = data else {throw NSError()}
        
        var json: AnyObject?
        
        do {
            json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as AnyObject
        } catch let error {
            throw error
        }
        
        guard let results = json as? [AnyObject] else {
            throw NSError()
        }
        
        var albuns: [Album] = []
        
        for result in results {
            guard let album = result as? [String: AnyObject] else {throw NSError()}
            
            let albumId = album["albumId"] as? Int
            let title = album["title"] as? String
            let thumbNail = album["thumbnailUrl"] as? String
            
            let id = album["id"] as? Int
            let url = album["url"] as? String
            
            let newAlbum = Album(albumId: albumId ?? 0, title: title ?? "", thumbNail: thumbNail ?? "", id: id ?? 0, url: url ?? "")
            albuns.append(newAlbum)
        }
        
        return albuns
    }
}
