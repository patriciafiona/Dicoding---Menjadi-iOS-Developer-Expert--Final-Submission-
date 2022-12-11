//
//  DetailGameResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation

public struct DetailGameModel: Equatable, Identifiable {
  public let id: Int?
  let isFavorite: Bool?
  let slug, name, nameOriginal, description: String?
  let released: String?
  let updated: String?
  let backgroundImage: String?
  let backgroundImageAdditional: String?
  let website: String?
  let rating: Double?
  let added: Int?
  let playtime: Int?
  let achievementsCount: Int?
  let ratingsCount, suggestionsCount: Int?
  let reviewsCount: Int?
  let parentPlatforms: [PlatformModel]?
  let platforms: [DetailPlatformModel]?
  let stores: [StoreDetailsModel]?
  let developers: [DeveloperInDetailGameModel]?
  let genres: [GenreInDetailsModel]?
  let tags: [TagModel]?
  let publishers: [PublisherModel]?
  let descriptionRaw: String?
}

public struct DetailPlatformModel: Equatable, Identifiable {
  public let id: UUID
  let platform: PlatformDetailsModel?
  let releasedAt: String?
  let requirements: PlatformRequirementModel?
}

public struct PlatformDetailsModel: Equatable, Identifiable{
  public var id: UUID
  let name, slug: String?
  let image: String?
  let yearEnd, yearStart: Int?
  let gamesCount: Int?
  let imageBackground: String?
}

public struct PlatformRequirementModel: Equatable, Identifiable{
  public let id: UUID
  let minimum: String?
}

public struct StoreDetailsModel: Equatable, Identifiable{
  public let id: UUID
  let url: String?
  let store: StoreModel?
}

public struct StoreModel: Equatable, Identifiable{
  public let id: UUID
  let name, slug: String?
  let gamesCount: Int?
  let domain: String?
  let imageBackground: String?
}

public struct DeveloperInDetailGameModel: Equatable, Identifiable{
  public let id: UUID
  let name, slug: String?
  let gamesCount: Int?
  let imageBackground: String?
}

public struct PublisherModel: Equatable, Identifiable{
  public let id: UUID
  let name, slug: String?
  let gamesCount: Int?
  let imageBackground: String?
}

public struct GenreInDetailsModel: Equatable, Identifiable{
  public let id: UUID
  let name, slug: String?
  let gamesCount: Int?
  let imageBackground: String?
}

public struct TagModel: Equatable, Identifiable{
  public let id: UUID
  let name, slug: String?
  let gamesCount: Int?
  let imageBackground: String?
}
