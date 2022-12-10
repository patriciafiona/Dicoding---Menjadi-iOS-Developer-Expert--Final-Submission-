//
//  GenreModel.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation

// MARK: - Result
struct GenreModel: Equatable, Identifiable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    var desc: String = "Unknown Description"
    let games: [GameInGenreModel]
}

// MARK: - Game
struct GameInGenreModel: Equatable, Identifiable {
    let id: Int?
    let name, slug: String?
    let added: Int?
}
