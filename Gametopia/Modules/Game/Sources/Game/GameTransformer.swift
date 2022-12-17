//
//  File.swift
//  
//
//  Created by Patricia Fiona on 11/12/22.
//

import Core

public struct GameTransformer {
  static func mapGameResponsesToDomains(
    input gameResponses: [GameResult]
  ) -> [GameDomainModel] {
    
    return gameResponses.map { result in
      return GameDomainModel(
        id: result.id ?? 0,
        name: result.name ?? "Unknown Name",
        released: result.released ?? "Unknown Release",
        backgroundImage: result.background_image ?? "",
        rating: result.rating ?? 0.0,
        ratingTop: result.rating_top ?? 0.0,
        suggestionsCount: result.suggestions_count ?? 0,
        updated: result.updated ?? "Unknown date",
        reviewsCount: result.reviews_count ?? 0,
        communityRating: result.community_rating ?? 0,
        platforms: (result.platforms ?? nil) as? [PlatformModel],
        genres: (result.genres ?? nil) as? [GenreInGameModel],
        parentPlatforms: (result.parent_platforms ?? nil) as? [ParentPlatformPlatformModel]
      )
    }
  }
}

