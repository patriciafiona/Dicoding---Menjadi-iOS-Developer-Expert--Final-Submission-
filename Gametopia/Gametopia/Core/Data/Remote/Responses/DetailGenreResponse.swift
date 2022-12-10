//
//  DetailGenreResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 25/11/22.
//

import Foundation

class DetailGenreResponse: Decodable {
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    var description: String?
}
