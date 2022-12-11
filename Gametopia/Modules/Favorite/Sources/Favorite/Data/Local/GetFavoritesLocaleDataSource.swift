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
 
 
public struct GetFavoritesLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Any
    public typealias Response = FavoriteModuleEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[FavoriteModuleEntity], Error> {
        return Future<[FavoriteModuleEntity], Error> { completion in
            let favorites: Results<FavoriteModuleEntity> = {
              _realm.objects(FavoriteModuleEntity.self)
                .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(favorites.toArray(ofType: FavoriteModuleEntity.self)))
          
        }.eraseToAnyPublisher()
    }
 
    public func add(entities: [FavoriteModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for favorite in entities {
                        _realm.add(favorite, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
            
        }.eraseToAnyPublisher()
    }
    
    public func get(id: String) -> AnyPublisher<FavoriteModuleEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int, entity: FavoriteModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}
