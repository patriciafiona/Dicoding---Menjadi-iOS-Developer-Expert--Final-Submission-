//
//  DeveloperMapper.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation
import RealmSwift

final class DeveloperMapper {
  
  static func mapDevelopersResponsesToEntities(
    input developersResponses: [DeveloperResult]
  ) -> [DeveloperEntity] {
    return developersResponses.map { result in
      let newDeveloper = DeveloperEntity()
      
      newDeveloper.id = String(result.id ?? 0)
      newDeveloper.name = result.name ?? "Unknown Name"
      newDeveloper.slug = result.slug ?? "Unknown Slug"
      newDeveloper.gameCount = result.gamesCount ?? 0
      newDeveloper.imageBackground = result.imageBackground ?? ""
      
      let temp = List<GameInDeveloperEntity>()
      for game in result.games! {
        let gameTemp = GameInDeveloperEntity()
        gameTemp.id = String(game.id ?? 0)
        gameTemp.added = game.added ?? 0
        gameTemp.slug = game.slug ?? "Unknown Slug"
        gameTemp.name = game.name ?? "Unknown Name"

        temp.append(gameTemp)
      }
      newDeveloper.games = temp
      return newDeveloper
    }
  }

  static func mapDeveloperEntitiesToDomains(
    input developerEntities: [DeveloperEntity]
  ) -> [DeveloperModel] {
    return developerEntities.map { result in
      return DeveloperModel(
        id: Int(result.id),
        name: result.name,
        slug: result.slug,
        gamesCount: result.gameCount,
        imageBackground: result.imageBackground,
        games: result.games.map { game in
          return GameInDeveloperModel(
            id: Int(game.id),
            name: game.name,
            slug: game.slug,
            added: game.added
          )
        }
      )
    }
  }
  
  static func mapDeveloperResponsesToDomains(
    input developerResponses: [DeveloperResult]
  ) -> [DeveloperModel] {
    
    return developerResponses.map { result in
      return DeveloperModel(
        id: result.id ?? 0,
        name: result.name ?? "Unknown Name",
        slug: result.slug ?? "Unknown Slug",
        gamesCount: result.gamesCount ?? 0,
        imageBackground: result.imageBackground ?? "",
        games: (result.games!) as? [GameInDeveloperModel] ?? []
      )
    }
  }
}
