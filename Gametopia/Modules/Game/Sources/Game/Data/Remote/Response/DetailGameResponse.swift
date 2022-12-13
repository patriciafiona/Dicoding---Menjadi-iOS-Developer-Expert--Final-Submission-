//
//  File.swift
//  
//
//  Created by Patricia Fiona on 13/12/22.
//

import Foundation

public struct DetailGameResponse: Decodable {
  let id: Int?
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
  let parentPlatforms: [PlatformInDetail]?
  let platforms: [DetailPlatform]?
  let stores: [StoreDetails]?
  let developers: [Developer]?
  let genres: [GenreInDetails]?
  let tags: [Tag]?
  let publishers: [Publisher]?
  let descriptionRaw: String?
}

public struct PlatformInDetail: Decodable {
  let platform: PlatformDetail
}

public struct PlatformDetail: Decodable {
    let id: Int?
    let name, slug: String?
}

public struct DetailPlatform: Decodable{
    let platform: PlatformDetails?
    let releasedAt: String?
    let requirements: PlatformRequirement?
}

public struct PlatformDetails: Decodable{
    let id: Int?
    let name, slug: String?
    let image: String?
    let yearEnd, yearStart: Int?
    let gamesCount: Int?
    let imageBackground: String?
}

public struct PlatformRequirement: Decodable{
    let minimum: String?
}

public struct StoreDetails: Decodable{
    let id: Int?
    let url: String?
    let store: Store?
}

public struct Store: Decodable{
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let domain: String?
    let imageBackground: String?
}

public struct Developer: Decodable{
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
}

public struct Publisher: Decodable{
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
}

public struct GenreInDetails: Decodable{
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
}

public struct Tag: Decodable{
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
}
