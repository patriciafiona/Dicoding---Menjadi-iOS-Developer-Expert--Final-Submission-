//
//  File.swift
//  
//
//  Created by Patricia Fiona on 11/12/22.
//

import Foundation

public struct GamesResponse: Decodable {
  let games: GameResponse
}

// MARK: - Welcome
public struct GameResponse: Decodable {
    let count: Int?
    let next, previous: String?
    let results: [GameResult]?
}

// MARK: - Result
public struct GameResult: Decodable {
    let id: Int?
    let name, released: String?
    let backgroundImage: String?
    let rating, ratingTop: Double?
    let suggestionsCount: Int?
    let updated: String?
    let reviewsCount: Int?
    let communityRating: Int?
    let platforms: [Platform]?
    let genres: [Genre]?
    let parentPlatforms: [ParentPlatformPlatform]?
}

// MARK: - Platform
public struct Platforms: Decodable {
    let platform: Platform?
    let releasedAt: String?
}

// MARK: - Platform
public struct Platform: Decodable {
    let id: Int?
    let name, slug: String?
}

// MARK: - ParentPlatformPlatform
public struct ParentPlatformPlatform: Decodable {
    let id: Int?
    let name, slug: String?
}

// MARK: - Genre
public struct Genre: Decodable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let language: String?
}
