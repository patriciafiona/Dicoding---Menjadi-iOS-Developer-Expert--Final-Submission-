//
//  File.swift
//  
//
//  Created by Patricia Fiona on 11/12/22.
//

import Core

public struct GameTransformer: Mapper {
  public typealias Response = [GameResult]
  public typealias Entity = [GameModuleEntity]
  public typealias Domain = [GameDomainModel]
  
  public init() {}
  
  public func transformResponseToDomain(response: [GameResult]) -> [GameDomainModel] {
    return response.map { result in
      return GameDomainModel(
        id: result.id ?? 0,
        name: result.name ?? "Unknown Name",
        released: result.released ?? "Unknown Release",
        backgroundImage: result.backgroundImage ?? "",
        rating: result.rating ?? 0.0,
        ratingTop: result.ratingTop ?? 0.0,
        suggestionsCount: result.suggestionsCount ?? 0,
        updated: result.updated ?? "Unknown date",
        reviewsCount: result.reviewsCount ?? 0,
        communityRating: result.communityRating ?? 0,
        platforms: (result.platforms ?? nil) as? [PlatformModel],
        genres: (result.genres ?? nil) as? [GenreInGameModel],
        parentPlatforms: (result.parentPlatforms ?? nil) as? [ParentPlatformPlatformModel]
      )
    }
  }
  
  public func transformResponseToEntity(response: [GameResult]) -> [GameModuleEntity] {
    return []
  }
  
  public func transformEntityToDomain(entity: [GameModuleEntity]) -> [GameDomainModel] {
    return []
  }
}

