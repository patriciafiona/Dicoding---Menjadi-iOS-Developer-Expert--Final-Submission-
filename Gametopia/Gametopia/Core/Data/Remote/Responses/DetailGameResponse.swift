//
//  DetailGameResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation

struct DetailGameResponse: Decodable {
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

struct PlatformInDetail: Decodable {
  let platform: PlatformDetail
}

struct PlatformDetail: Decodable {
    let id: Int?
    let name, slug: String?
}

struct DetailPlatform: Decodable{
    let platform: PlatformDetails?
    let releasedAt: String?
    let requirements: PlatformRequirement?
}

struct PlatformDetails: Decodable{
    let id: Int?
    let name, slug: String?
    let image: String?
    let yearEnd, yearStart: Int?
    let gamesCount: Int?
    let imageBackground: String?
}

struct PlatformRequirement: Decodable{
    let minimum: String?
}

struct StoreDetails: Decodable{
    let id: Int?
    let url: String?
    let store: Store?
}

struct Store: Decodable{
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let domain: String?
    let imageBackground: String?
}

struct Developer: Decodable{
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
}

struct Publisher: Decodable{
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
}

struct GenreInDetails: Decodable{
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
}

struct Tag: Decodable{
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
}
