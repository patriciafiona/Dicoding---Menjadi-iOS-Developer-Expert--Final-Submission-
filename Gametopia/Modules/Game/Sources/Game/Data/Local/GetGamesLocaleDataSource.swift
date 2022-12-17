//
//  File.swift
//  
//
//  Created by Patricia Fiona on 11/12/22.
//

import Core
import Combine
import RealmSwift
import Foundation


public struct GetGamesLocaleDataSource {
  public typealias Request = Any
  public typealias Response = GameModuleEntity
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  func getGames() -> AnyPublisher<[GameModuleEntity], Error> {
    return Future<[GameModuleEntity], Error> { completion in
      let detailGames: Results<GameModuleEntity> = {
        _realm.objects(GameModuleEntity.self)
          .sorted(byKeyPath: "name", ascending: true)
        }()
      completion(.success(detailGames.toArray(ofType: GameModuleEntity.self)))
    }.eraseToAnyPublisher()
  }
  
  func getBestRatingGames() -> AnyPublisher<[GameModuleEntity], Error> {
    return Future<[GameModuleEntity], Error> { completion in
      let detailGames: Results<GameModuleEntity> = {
        _realm.objects(GameModuleEntity.self)
          .sorted(byKeyPath: "rating", ascending: false)
      }()
      completion(.success(detailGames.toArray(ofType: GameModuleEntity.self, limits: 10)))
    }.eraseToAnyPublisher()
  }
  
  func addGames(
    from detailGames: [GameModuleEntity]
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          for game in detailGames {
            //Should be manual because need to change from game array to game list
            let temp = GameModuleEntity()
            temp.id = game.id
            temp.name = game.name
            temp.nameOriginal = game.nameOriginal
            temp.slug = game.slug
            temp.desc = game.desc
            temp.released = game.released
            temp.updated = game.updated
            print("backgroundImage: \(game.backgroundImage)")
            temp.backgroundImage = game.backgroundImage
            temp.backgroundImageAdditional = game.backgroundImageAdditional
            temp.website = game.website
            temp.rating = game.rating
            temp.added = game.added
            temp.playtime = game.playtime
            temp.achievementsCount = game.achievementsCount
            temp.ratingsCount = game.ratingsCount
            temp.suggestionsCount = game.suggestionsCount
            temp.reviewsCount = game.reviewsCount
            temp.descriptionRaw = game.descriptionRaw

            temp.parentPlatforms.append(objectsIn: game.parentPlatforms)
            temp.platforms.append(objectsIn: game.platforms)
            temp.stores.append(objectsIn: game.stores)
            temp.developers.append(objectsIn: game.developers)
            temp.genres.append(objectsIn: game.genres)
            temp.tags.append(objectsIn: game.tags)
            temp.publishers.append(objectsIn: game.publishers)
            temp.parentPlatforms.append(objectsIn: game.parentPlatforms)

            _realm.add(temp, update: .all)
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
  
  func addGame(
    from game: GameModuleEntity
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          //Should be manual because need to change from game array to game list
          let temp = GameModuleEntity()
          temp.id = game.id
          temp.name = game.name
          temp.nameOriginal = game.nameOriginal
          temp.slug = game.slug
          temp.desc = game.desc
          temp.released = game.released
          temp.updated = game.updated
          temp.backgroundImage = game.backgroundImage
          temp.backgroundImageAdditional = game.backgroundImageAdditional
          temp.website = game.website
          temp.rating = game.rating
          temp.added = game.added
          temp.playtime = game.playtime
          temp.achievementsCount = game.achievementsCount
          temp.ratingsCount = game.ratingsCount
          temp.suggestionsCount = game.suggestionsCount
          temp.reviewsCount = game.reviewsCount
          temp.descriptionRaw = game.descriptionRaw

          temp.parentPlatforms.append(objectsIn: game.parentPlatforms)
          temp.platforms.append(objectsIn: game.platforms)
          temp.stores.append(objectsIn: game.stores)
          temp.developers.append(objectsIn: game.developers)
          temp.genres.append(objectsIn: game.genres)
          temp.tags.append(objectsIn: game.tags)
          temp.publishers.append(objectsIn: game.publishers)
          temp.parentPlatforms.append(objectsIn: game.parentPlatforms)

          _realm.add(temp, update: .all)
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
  
  func getDetailGame(id: Int) -> AnyPublisher<GameModuleEntity, Error> {
    return Future<GameModuleEntity, Error> { completion in
      let detail: GameModuleEntity = {
        _realm.object(ofType: GameModuleEntity.self, forPrimaryKey: id)
      }() ?? GameModuleEntity()
      completion(.success(detail))
    }.eraseToAnyPublisher()
  }
  
  func updateGames(gameEntity: GameModuleEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        let currentData = _realm.objects(GameModuleEntity.self).where {
          $0.id == gameEntity.id
      }.first!
        //Update the all data that not added before
        
        try _realm.write {
          currentData.setValue(gameEntity.slug, forKey: "slug")
          currentData.setValue(gameEntity.nameOriginal, forKey: "nameOriginal")
          currentData.setValue(gameEntity.desc, forKey: "desc")
          currentData.setValue(gameEntity.backgroundImageAdditional, forKey: "backgroundImageAdditional")
          currentData.setValue(gameEntity.website, forKey: "website")
          currentData.setValue(gameEntity.added, forKey: "added")
          currentData.setValue(gameEntity.playtime, forKey: "playtime")
          currentData.setValue(gameEntity.achievementsCount, forKey: "achievementsCount")
          currentData.setValue(gameEntity.ratingsCount, forKey: "ratingsCount")
          currentData.setValue(gameEntity.parentPlatforms, forKey: "parentPlatforms")
          currentData.setValue(gameEntity.platforms, forKey: "platforms")
          currentData.setValue(gameEntity.stores, forKey: "stores")
          currentData.setValue(gameEntity.developers, forKey: "developers")
          currentData.setValue(gameEntity.genres, forKey: "genres")
          currentData.setValue(gameEntity.tags, forKey: "tags")
          currentData.setValue(gameEntity.publishers, forKey: "publishers")
          currentData.setValue(gameEntity.descriptionRaw, forKey: "descriptionRaw")
        }
        completion(.success(true))
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
}
