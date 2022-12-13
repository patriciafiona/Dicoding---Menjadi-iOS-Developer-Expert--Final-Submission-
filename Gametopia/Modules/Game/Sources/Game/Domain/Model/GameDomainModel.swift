//
//  File.swift
//
//
//  Created by Patricia Fiona on 11/12/22.
//

import Foundation

public struct GameDomainModel: Equatable {
  public let id: Int?
  public let name, released: String?
  public let backgroundImage: String?
  public let rating, ratingTop: Double?
  public let suggestionsCount: Int?
  public let updated: String?
  public let reviewsCount: Int?
  public let communityRating: Int?
  public let platforms: [PlatformModel]?
  public let genres: [GenreInGameModel]?
  public let parentPlatforms: [ParentPlatformPlatformModel]?
}

// MARK: - Platform
public struct PlatformsModel: Equatable {
    let platform: PlatformModel?
    let releasedAt: String?
}

// MARK: - Platform
public struct PlatformModel: Equatable, Identifiable {
  public let id: UUID
  public let name, slug: String?
}

// MARK: - ParentPlatformPlatform
public struct ParentPlatformPlatformModel: Equatable, Identifiable {
  public let id: Int?
    let name, slug: String?
}

// MARK: - Genre
public struct GenreInGameModel: Equatable, Identifiable {
  public let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let language: String?
}


