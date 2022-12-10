//
//  GameMapper.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation

final class GameMapper {
  static func mapGameResponsesToDomains(
    input gameResponses: [GameResult]
  ) -> [GameModel] {
    
    return gameResponses.map { result in
      return GameModel(
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
}
