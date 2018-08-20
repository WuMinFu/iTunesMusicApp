//
//  iTunesMusic.swift
//  iTunesMusicApp
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation

struct Song: Codable {
    var artistName: String
    var collectionName: String
    var trackName: String
    var artworkUrl100: URL
    var releaseDate: String
    var collectionPrice: Double
    var trackPrice: Double
    var country: String
    var currency: String
    var previewUrl: URL
}



struct iTunesMusic: Codable {
    
    var results: [Song]
}
