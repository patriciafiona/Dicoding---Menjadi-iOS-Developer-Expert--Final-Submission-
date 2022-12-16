//
//  LocaleDataSource.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
  func getGames() -> AnyPublisher<[GameEntity], Error>
  func getSortedGames(sortedFromBest: Bool) -> AnyPublisher<[GameEntity], Error>
  func getBestRatingGames() -> AnyPublisher<[GameEntity], Error>
  func addGames(from game: [GameEntity]) -> AnyPublisher<Bool, Error>
  func addGame(from game: GameEntity) -> AnyPublisher<Bool, Error>
  func updateGames(gameEntity: GameEntity) -> AnyPublisher<Bool, Error>
  func getDetailGame(id: Int) -> AnyPublisher<GameEntity, Error>
  
  func updateFavoriteGames(id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error>
  func getAllFavoriteGames() -> AnyPublisher<[GameEntity], Error>
}

final class LocaleDataSource: NSObject {
  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  func getAllFavoriteGames() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let detailGames: Results<GameEntity> = {
          realm.objects(GameEntity.self)
            .filter("isFavorite == true")
        }()
        completion(.success(detailGames.toArray(ofType: GameEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func updateFavoriteGames(id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          let currentData = realm.objects(GameEntity.self).where {
            $0.id == id
        }.first!
          //Update the nil description
          try realm.write {
            currentData.setValue(isFavorite, forKey: "isFavorite")
          }
          completion(.success(true))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getSortedGames(sortedFromBest: Bool) -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let detailGames: Results<GameEntity> = {
          realm.objects(GameEntity.self)
            .sorted(byKeyPath: "rating", ascending: !sortedFromBest)
        }()
        completion(.success(detailGames.toArray(ofType: GameEntity.self, limit: 10)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getGames() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let detailGames: Results<GameEntity> = {
          realm.objects(GameEntity.self)
            .sorted(byKeyPath: "name", ascending: true)
        }()
        completion(.success(detailGames.toArray(ofType: GameEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getBestRatingGames() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let detailGames: Results<GameEntity> = {
          realm.objects(GameEntity.self)
            .sorted(byKeyPath: "rating", ascending: false)
        }()
        completion(.success(detailGames.toArray(ofType: GameEntity.self, limit: 10)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addGames(
    from detailGames: [GameEntity]
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for game in detailGames {
              //Should be manual because need to change from game array to game list
              let temp = GameEntity()
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

              realm.add(temp, update: .all)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addGame(
    from game: GameEntity
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            //Should be manual because need to change from game array to game list
            let temp = GameEntity()
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

            realm.add(temp, update: .all)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getDetailGame(id: Int) -> AnyPublisher<GameEntity, Error> {
    return Future<GameEntity, Error> { completion in
      if let realm = self.realm {
        let detail: GameEntity = {
          realm.object(ofType: GameEntity.self, forPrimaryKey: id)
        }() ?? GameEntity()
        completion(.success(detail))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func updateGames(gameEntity: GameEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          let currentData = realm.objects(GameEntity.self).where {
            $0.id == gameEntity.id
        }.first!
          //Update the all data that not added before
          
          try realm.write {
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
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
}

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
  
  func toArray<T>(ofType: T.Type, limit: Int) -> [T] {
    var array = [T]()
    if(count != 0){
      for index in 0 ..< limit {
        if let result = self[index] as? T {
          array.append(result)
        }
      }
    }
    return array
  }
}
