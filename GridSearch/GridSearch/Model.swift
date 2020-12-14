//
//  Model.swift
//  GridSearch
//
//  Created by Nipun Garg on 12/13/20.
//

import Foundation

struct RSS: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [AppData]
}

struct AppData: Decodable, Hashable {
    let copyright, name, artworkUrl100, releaseDate: String
}
