//
//  File.swift
//  
//
//  Created by Patricia Fiona on 15/12/22.
//

import Foundation
import Core
import Combine
import RealmSwift
import Foundation

public struct GetDevelopersLocaleDataSource: LocaleDataSource {
  public typealias Request = Any
  public typealias Response = DeveloperModuleEntity
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: Any?) -> AnyPublisher<[DeveloperModuleEntity], Error> {
    return Future<[DeveloperModuleEntity], Error> { completion in
      let developers: Results<DeveloperModuleEntity> = {
        _realm.objects(DeveloperModuleEntity.self)
          .sorted(byKeyPath: "name", ascending: true)
      }()
      completion(.success(developers.toArray(ofType: DeveloperModuleEntity.self)))
      
    }.eraseToAnyPublisher()
  }
  
  public func add(entities: [DeveloperModuleEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          for developer in entities {
            _realm.add(developer, update: .all)
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
      
    }.eraseToAnyPublisher()
  }
  
  public func get(id: String) -> AnyPublisher<DeveloperModuleEntity, Error> {
    fatalError()
  }
  
  public func update(id: Int, entity: DeveloperModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func add(entities: DeveloperModuleEntity) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func update(id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
