//
//  DetailGameResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation
import Game

public struct DetailGameDomainModel: Equatable, Identifiable {
  public let id: Int?
  public let isFavorite: Bool?
  public let slug, name, nameOriginal, description: String?
  public let released: String?
  public let updated: String?
  public let backgroundImage: String?
  public let backgroundImageAdditional: String?
  public let website: String?
  public let rating: Double?
  public let added: Int?
  public let playtime: Int?
  public let achievementsCount: Int?
  public let ratingsCount, suggestionsCount: Int?
  public let reviewsCount: Int?
  public let parentPlatforms: [PlatformModel]?
  public let platforms: [DetailPlatformDomainModel]?
  public let stores: [StoreDetailsDomainModel]?
  public let developers: [DeveloperInDetailGameDomainModel]?
  public let genres: [GenreInDetailsDomainModel]?
  public let tags: [TagDomainModel]?
  public let publishers: [PublisherDomainModel]?
  public let descriptionRaw: String?
}

public struct PlatformModel: Equatable, Identifiable {
  public let id: UUID
  public let name, slug: String?
}

public struct DetailPlatformDomainModel: Equatable, Identifiable {
    public let id: UUID
    public let platform: PlatformDetailsDomainModel?
    public let releasedAt: String?
    public let requirements: PlatformRequirementDomainModel?
}

public struct PlatformDetailsDomainModel: Equatable, Identifiable{
    public var id: UUID
    public let name, slug: String?
    public let image: String?
    public let yearEnd, yearStart: Int?
    public let gamesCount: Int?
    public let imageBackground: String?
}

public struct PlatformRequirementDomainModel: Equatable, Identifiable{
  public let id: UUID
  public let minimum: String?
}

public struct StoreDetailsDomainModel: Equatable, Identifiable{
    public let id: UUID
    public let url: String?
    public let store: StoreDomainModel?
}

public struct StoreDomainModel: Equatable, Identifiable{
    public let id: UUID
    public let name, slug: String?
    public let gamesCount: Int?
    public let domain: String?
    public let imageBackground: String?
}

public struct DeveloperInDetailGameDomainModel: Equatable, Identifiable{
    public let id: UUID
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
}

public struct PublisherDomainModel: Equatable, Identifiable{
    public let id: UUID
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
}

public struct GenreInDetailsDomainModel: Equatable, Identifiable{
    public let id: UUID
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
}

public struct TagDomainModel: Equatable, Identifiable{
    public let id: UUID
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
}
