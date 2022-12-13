//
//  File.swift
//  
//
//  Created by Patricia Fiona on 11/12/22.
//

import Core
import Combine
 
public struct GetGamesRepository<
    GameLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
GameLocaleDataSource.Response == GameModuleEntity,
    RemoteDataSource.Response == [GameResult],
    Transformer.Response == [GameResult],
    Transformer.Entity == [GameModuleEntity],
Transformer.Domain == [GameDomainModel] {
  
    public typealias Request = Any
    public typealias Response = [GameDomainModel]
    
    private let _localeDataSource: GameLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: GameLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[GameDomainModel], Error> {
        return _localeDataSource.list(request: nil)
          .flatMap { result -> AnyPublisher<[GameDomainModel], Error> in
            if result.isEmpty {
              return _remoteDataSource.execute(request: nil)
                .map { _mapper.transformResponseToEntity(response: $0) }
                .catch { _ in _localeDataSource.list(request: nil) }
                .flatMap { _localeDataSource.add(entities: $0) }
                .filter { $0 }
                .flatMap { _ in _localeDataSource.list(request: nil)
                  .map { _mapper.transformEntityToDomain(entity: $0) }
                }
                .eraseToAnyPublisher()
            } else {
              return _localeDataSource.list(request: nil)
                .map { _mapper.transformEntityToDomain(entity: $0) }
                .eraseToAnyPublisher()
            }
          }.eraseToAnyPublisher()
    }
  
    public func execute(request: Request?, keyword: String) -> AnyPublisher<[GameDomainModel], Error> {
      fatalError()
    }
  
    public func execute(request: Request?, id: Int, isFavorite: Bool) -> AnyPublisher<[GameDomainModel], Error> {
      fatalError()
    }
  
  public func execute(request: Request?, id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
