//
//  File.swift
//  
//
//  Created by Patricia Fiona on 14/12/22.
//

import Foundation
import RealmSwift

public final class GenreTransformer {
  
  static func mapGenresResponsesToEntities(
    input genreResponses: [GenreResult]
  ) -> [GenreModuleEntity] {
    return genreResponses.map { result in
      let newGenre = GenreModuleEntity()
      
      newGenre.id = result.id ?? 0
      newGenre.name = result.name ?? "Unknown Name"
      newGenre.slug = result.slug ?? "Unknown Slug"
      newGenre.gameCount = result.games_count ?? 0
      newGenre.imageBackground = result.image_background ?? ""
      let temp = List<GameInGenreEntity>()
      for game in result.games! {
        let gameTemp = GameInGenreEntity()
        gameTemp.id = String(game.id ?? 0)
        gameTemp.added = game.added ?? 0
        gameTemp.slug = game.slug ?? "Unknown Slug"
        gameTemp.name = game.name ?? "Unknown Name"
        
        temp.append(
          gameTemp
        )
      }
      newGenre.games = temp
      return newGenre
    }
  }
  
  static func mapGenresResponsesToEntity(
    input result: DetailGenreResponse
  ) -> GenreModuleEntity {
    let newGenre = GenreModuleEntity()
    
    newGenre.id = result.id ?? 0
    newGenre.name = result.name ?? "Unknown Name"
    newGenre.slug = result.slug ?? "Unknown Slug"
    newGenre.gameCount = result.games_count ?? 0
    newGenre.imageBackground = result.image_background ?? ""
    newGenre.desc = result.description ?? ""
    return newGenre
  }

  static func mapGenresEntitiesToDomains(
    input genreEntities: [GenreModuleEntity]
  ) -> [GenreDomainModel] {
    return genreEntities.map { result in
      return GenreDomainModel(
        id: Int(result.id),
        name: result.name,
        slug: result.slug,
        gamesCount: result.gameCount,
        imageBackground: result.imageBackground,
        games: result.games.map { game in
          return GameInGenreModel(
            id: Int(game.id),
            name: game.name,
            slug: game.slug,
            added: game.added
          )
        }
      )
    }
  }
  
  static func mapGenresEntityToDomains(
    input result: GenreModuleEntity
  ) -> GenreDomainModel {
    return GenreDomainModel(
      id: Int(result.id),
      name: result.name,
      slug: result.slug,
      gamesCount: result.gameCount,
      imageBackground: result.imageBackground,
      desc: result.desc,
      games: result.games.map { game in
        return GameInGenreModel(
          id: Int(game.id),
          name: game.name,
          slug: game.slug,
          added: game.added
        )
      }
    )
  }
  
  static func mapGenreResponsesToDomains(
    input genreResponses: [GenreResult]
  ) -> [GenreDomainModel] {
    
    return genreResponses.map { result in
      return GenreDomainModel(
        id: result.id ?? 0,
        name: result.name ?? "Unknown Name",
        slug: result.slug ?? "Unknown Slug",
        gamesCount: result.games_count ?? 0,
        imageBackground: result.image_background ?? "",
        games: (result.games!) as? [GameInGenreModel] ?? []
      )
    }
  }
}
