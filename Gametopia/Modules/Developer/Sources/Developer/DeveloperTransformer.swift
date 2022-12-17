//
//  File.swift
//  
//
//  Created by Patricia Fiona on 16/12/22.
//

import Foundation
import Core
import RealmSwift

public struct DeveloperTransformer: Mapper {
    public typealias Response = [DeveloperResult]
    public typealias Entity = [DeveloperModuleEntity]
    public typealias Domain = [DeveloperDomainModel]
    
    public init() {}
    
    public func transformResponseToEntity(response: [DeveloperResult]) -> [DeveloperModuleEntity] {
      return response.map { result in
        let newDeveloper = DeveloperModuleEntity()
        
        newDeveloper.id = String(result.id ?? 0)
        newDeveloper.name = result.name ?? "Unknown Name"
        newDeveloper.slug = result.slug ?? "Unknown Slug"
        newDeveloper.gameCount = result.games_count ?? 0
        newDeveloper.imageBackground = result.image_background ?? ""
        
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
    
    public func transformEntityToDomain(entity: [DeveloperModuleEntity]) -> [DeveloperDomainModel] {
      return entity.map { result in
        return DeveloperDomainModel(
          id: Int(result.id),
          name: result.name,
          slug: result.slug,
          gamesCount: result.gameCount,
          imageBackground: result.imageBackground,
          games: result.games.map { game in
            return GameInDeveloperDomainModel(
              id: Int(game.id),
              name: game.name,
              slug: game.slug,
              added: game.added
            )
          }
        )
      }
    }
  
    public func transformResponseToDomain(response: [DeveloperResult]) -> [DeveloperDomainModel] {
      return response.map { result in
        return DeveloperDomainModel(
          id: result.id ?? 0,
          name: result.name ?? "Unknown Name",
          slug: result.slug ?? "Unknown Slug",
          gamesCount: result.games_count ?? 0,
          imageBackground: result.image_background ?? "",
          games: (result.games!) as? [GameInDeveloperDomainModel] ?? []
        )
      }
    }
}

