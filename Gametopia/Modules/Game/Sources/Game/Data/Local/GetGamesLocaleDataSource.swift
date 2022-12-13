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


public struct GetGamesLocaleDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = GameModuleEntity
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  //Get All games
  public func list(request: Any?) -> AnyPublisher<[GameModuleEntity], Error> {
    return Future<[GameModuleEntity], Error> { completion in
      let games: Results<GameModuleEntity> = {
        _realm.objects(GameModuleEntity.self)
          .sorted(byKeyPath: "name", ascending: true)
      }()
      completion(.success(games.toArray(ofType: GameModuleEntity.self)))
      
    }.eraseToAnyPublisher()
  }
  
  //Add games
  public func add(entities: [GameModuleEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          for game in entities {
            _realm.add(game, update: .all)
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
      
    }.eraseToAnyPublisher()
  }
  
  //Get sorted game
  public func list(sortedFromBest: Bool) -> AnyPublisher<[GameModuleEntity], Error> {
    return Future<[GameModuleEntity], Error> { completion in
      let detailGames: Results<GameModuleEntity> = {
        _realm.objects(GameModuleEntity.self)
          .sorted(byKeyPath: "rating", ascending: !sortedFromBest)
      }()
      completion(.success(detailGames.toArray(ofType: GameModuleEntity.self, limits: 10)))
    }.eraseToAnyPublisher()
  }
  
  //Get game based best rating
  public func listBestRating() -> AnyPublisher<[GameModuleEntity], Error> {
    return Future<[GameModuleEntity], Error> { completion in
      let detailGames: Results<GameModuleEntity> = {
        _realm.objects(GameModuleEntity.self)
          .sorted(byKeyPath: "rating", ascending: false)
      }()
      completion(.success(detailGames.toArray(ofType: GameModuleEntity.self, limits: 10)))
    }.eraseToAnyPublisher()
  }
  //Add game
  public func add(entity: GameModuleEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          //Should be manual because need to change from game array to game list
          let temp = GameModuleEntity()
          temp.id = entity.id
          temp.name = entity.name
          temp.nameOriginal = entity.nameOriginal
          temp.slug = entity.slug
          temp.desc = entity.desc
          temp.released = entity.released
          temp.updated = entity.updated
          temp.backgroundImage = entity.backgroundImage
          temp.backgroundImageAdditional = entity.backgroundImageAdditional
          temp.website = entity.website
          temp.rating = entity.rating
          temp.added = entity.added
          temp.playtime = entity.playtime
          temp.achievementsCount = entity.achievementsCount
          temp.ratingsCount = entity.ratingsCount
          temp.suggestionsCount = entity.suggestionsCount
          temp.reviewsCount = entity.reviewsCount
          temp.descriptionRaw = entity.descriptionRaw

          temp.parentPlatforms.append(objectsIn: entity.parentPlatforms)
          temp.platforms.append(objectsIn: entity.platforms)
          temp.stores.append(objectsIn: entity.stores)
          temp.developers.append(objectsIn: entity.developers)
          temp.genres.append(objectsIn: entity.genres)
          temp.tags.append(objectsIn: entity.tags)
          temp.publishers.append(objectsIn: entity.publishers)
          temp.parentPlatforms.append(objectsIn: entity.parentPlatforms)

          _realm.add(temp, update: .all)
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
  //Update game
  public func updateGames(entity: GameModuleEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        let currentData = _realm.objects(GameModuleEntity.self).where {
          $0.id == entity.id
      }.first!
        //Update the all data that not added before
        try _realm.write {
          currentData.setValue(entity.slug, forKey: "slug")
          currentData.setValue(entity.nameOriginal, forKey: "nameOriginal")
          currentData.setValue(entity.desc, forKey: "desc")
          currentData.setValue(entity.backgroundImageAdditional, forKey: "backgroundImageAdditional")
          currentData.setValue(entity.website, forKey: "website")
          currentData.setValue(entity.added, forKey: "added")
          currentData.setValue(entity.playtime, forKey: "playtime")
          currentData.setValue(entity.achievementsCount, forKey: "achievementsCount")
          currentData.setValue(entity.ratingsCount, forKey: "ratingsCount")
          currentData.setValue(entity.parentPlatforms, forKey: "parentPlatforms")
          currentData.setValue(entity.platforms, forKey: "platforms")
          currentData.setValue(entity.stores, forKey: "stores")
          currentData.setValue(entity.developers, forKey: "developers")
          currentData.setValue(entity.genres, forKey: "genres")
          currentData.setValue(entity.tags, forKey: "tags")
          currentData.setValue(entity.publishers, forKey: "publishers")
          currentData.setValue(entity.descriptionRaw, forKey: "descriptionRaw")
        }
        completion(.success(true))
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
  
  //Get game detail
  public func getDetailGame(id: Int) -> AnyPublisher<GameModuleEntity, Error> {
    return Future<GameModuleEntity, Error> { completion in
      let detail: GameModuleEntity = {
        _realm.object(ofType: GameModuleEntity.self, forPrimaryKey: id)
      }() ?? GameModuleEntity()
      completion(.success(detail))
    }.eraseToAnyPublisher()
  }
  
  public func get(id: String) -> AnyPublisher<GameModuleEntity, Error> {
    fatalError()
  }
  
  public func update(id: Int, entity: GameModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func update(id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func add(entities: GameModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
