//
//  File.swift
//  
//
//  Created by Patricia Fiona on 13/12/22.
//

import Foundation

public struct DetailGameResponse: Decodable {
  let id: Int?
  let slug, name, name_original, description: String?
  let released: String?
  let updated: String?
  let background_image: String?
  let background_image_additional: String?
  let website: String?
  let rating: Double?
  let added: Int?
  let playtime: Int?
  let achievements_count: Int?
  let ratings_count, suggestions_count: Int?
  let reviews_count: Int?
  let parent_platforms: [PlatformInDetail]?
  let platforms: [DetailPlatform]?
  let stores: [StoreDetails]?
  let developers: [Developer]?
  let genres: [GenreInDetails]?
  let tags: [Tag]?
  let publishers: [Publisher]?
  let description_raw: String?
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
    let released_at: String?
    let requirements: PlatformRequirement?
}

public struct PlatformDetails: Decodable{
    let id: Int?
    let name, slug: String?
    let image: String?
    let year_end, year_start: Int?
    let games_count: Int?
    let image_background: String?
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
    let games_count: Int?
    let domain: String?
    let image_background: String?
}

public struct Developer: Decodable{
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
}

public struct Publisher: Decodable{
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
}

public struct GenreInDetails: Decodable{
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
}

public struct Tag: Decodable{
    let id: Int?
    let name, slug: String?
    let games_count: Int?
    let image_background: String?
}
