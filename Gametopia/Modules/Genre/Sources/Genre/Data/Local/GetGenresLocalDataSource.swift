//
//  File.swift
//  
//
//  Created by Patricia Fiona on 14/12/22.
//

import Core
import Combine
import RealmSwift
import Foundation


public struct GetGenresLocaleDataSource {  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  func getDetailGenre(id: Int) -> AnyPublisher<GenreModuleEntity, Error> {
    return Future<GenreModuleEntity, Error> { completion in
      let genre: GenreModuleEntity = {
        _realm.object(ofType: GenreModuleEntity.self, forPrimaryKey: id)
      }() ?? GenreModuleEntity()
      completion(.success(genre))
    }.eraseToAnyPublisher()
  }
  
  func updateGenre(id: Int, desc: String) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        let currentData = _realm.objects(GenreModuleEntity.self).where {
          $0.id == id
      }.first!
        //Update the nil description
        try _realm.write {
          currentData.setValue(desc, forKey: "desc")
        }
        completion(.success(true))
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
  
  func getGenres() -> AnyPublisher<[GenreModuleEntity], Error> {
    return Future<[GenreModuleEntity], Error> { completion in
      let genres: Results<GenreModuleEntity> = {
        _realm.objects(GenreModuleEntity.self)
          .sorted(byKeyPath: "name", ascending: true)
      }()
      completion(.success(genres.toArray(ofType: GenreModuleEntity.self)))
    }.eraseToAnyPublisher()
  }
 
  func addGenres(
    from genres: [GenreModuleEntity]
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          for genre in genres {
            //Should be manual because need to change from game array to game list
            let temp = GenreModuleEntity()
            temp.id = genre.id
            temp.name = genre.name
            temp.slug = genre.slug
            temp.gameCount = genre.gameCount
            temp.imageBackground = genre.imageBackground
            temp.games.append(objectsIn: genre.games)
            _realm.add(temp, update: .all)
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
}
