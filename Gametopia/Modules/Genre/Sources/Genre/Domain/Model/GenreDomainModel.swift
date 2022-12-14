//
//  File.swift
//  
//
//  Created by Patricia Fiona on 14/12/22.
//

import Foundation

// MARK: - Result
public struct GenreDomainModel: Equatable, Identifiable {
    public let id: Int?
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
    public var desc: String = "Unknown Description"
    public let games: [GameInGenreModel]
}

// MARK: - Game
public struct GameInGenreModel: Equatable, Identifiable {
    public let id: Int?
    public let name, slug: String?
    public let added: Int?
}
