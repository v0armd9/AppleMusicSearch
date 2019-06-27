//
//  AppleItem.swift
//  AppleMusicSearch
//
//  Created by Darin Marcus Armstrong on 6/27/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import Foundation

struct TopLevelJSON: Codable {
    let results: [AppleItem]
}

struct AppleItem: Codable {
    let trackName: String
    let artist: String
    let album: String
    let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case trackName
        case artist = "artistName"
        case album = "collectionName"
        case imageURL = "artworkUrl30"
        
    }
}
