//
//  File.swift
//  
//
//  Created by Patricia Fiona on 13/12/22.
//

import Foundation

public struct SearchResponse: Decodable {
    var count: Int?
    var next, previous: String?
    var results: [SearchResult]?
}

public struct SearchResult: Decodable{
    var id: Int?
    var name, slug: String?
    var playtime: Int?
    var released: String?
    var rating: Double?
    var score: String?
    var backgroundImage: String?
}
