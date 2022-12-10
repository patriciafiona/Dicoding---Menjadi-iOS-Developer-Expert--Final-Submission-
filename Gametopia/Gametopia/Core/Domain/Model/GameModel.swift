//
//  GameModel.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation

struct GameModel: Equatable {
    let id: Int?
    let name, released: String?
    let backgroundImage: String?
    let rating, ratingTop: Double?
    let suggestionsCount: Int?
    let updated: String?
    let reviewsCount: Int?
    let communityRating: Int?
    let platforms: [PlatformModel]?
    let genres: [GenreInGameModel]?
    let parentPlatforms: [ParentPlatformPlatformModel]?
}

// MARK: - Platform
struct PlatformsModel: Equatable {
    let platform: PlatformModel?
    let releasedAt: String?
}

// MARK: - Platform
struct PlatformModel: Equatable, Identifiable {
    let id: UUID
    let name, slug: String?
}

// MARK: - ParentPlatformPlatform
struct ParentPlatformPlatformModel: Equatable, Identifiable {
    let id: Int?
    let name, slug: String?
}

// MARK: - Genre
struct GenreInGameModel: Equatable, Identifiable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let language: String?
}

