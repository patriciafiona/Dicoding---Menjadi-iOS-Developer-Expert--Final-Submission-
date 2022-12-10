// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct GamesResponse: Decodable {
  let games: GameResponse
}

// MARK: - Welcome
struct GameResponse: Decodable {
    let count: Int?
    let next, previous: String?
    let results: [GameResult]?
}

// MARK: - Result
struct GameResult: Decodable {
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
struct Platforms: Decodable {
    let platform: Platform?
    let releasedAt: String?
}

// MARK: - Platform
struct Platform: Decodable {
    let id: Int?
    let name, slug: String?
}

// MARK: - ParentPlatformPlatform
struct ParentPlatformPlatform: Decodable {
    let id: Int?
    let name, slug: String?
}

// MARK: - Genre
struct Genre: Decodable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let language: String?
}
