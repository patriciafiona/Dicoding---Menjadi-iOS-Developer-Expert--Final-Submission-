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
    
    public func list(request: Any?) -> AnyPublisher<[GameModuleEntity], Error> {
        return Future<[GameModuleEntity], Error> { completion in
            let games: Results<GameModuleEntity> = {
              _realm.objects(GameModuleEntity.self)
                .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(games.toArray(ofType: GameModuleEntity.self)))
          
        }.eraseToAnyPublisher()
    }
 
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
    
    public func get(id: String) -> AnyPublisher<GameModuleEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int, entity: GameModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}
