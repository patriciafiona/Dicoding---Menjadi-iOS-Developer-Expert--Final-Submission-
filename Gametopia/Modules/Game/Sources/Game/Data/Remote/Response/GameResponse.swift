//
//  File.swift
//  
//
//  Created by Patricia Fiona on 11/12/22.
//

import Foundation

public struct GamesResponse: Decodable {
  public let games: GameResponse
}

// MARK: - Welcome
public struct GameResponse: Decodable {
    let count: Int?
    let next, previous: String?
    public let results: [GameResult]?
}

// MARK: - Result
public struct GameResult: Decodable {
    let id: Int?
    let name, released: String?
    let background_image: String?
    let rating, rating_top: Double?
    let suggestions_count: Int?
    let updated: String?
    let reviews_count: Int?
    let community_rating: Int?
    let platforms: [Platform]?
    let genres: [Genre]?
    let parent_platforms: [ParentPlatformPlatform]?
}

// MARK: - Platform
public struct Platforms: Decodable {
    let platform: Platform?
    let released_at: String?
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
    let games_count: Int?
    let image_background: String?
    let language: String?
}
