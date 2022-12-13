//
//  File.swift
//
//
//  Created by Patricia Fiona on 11/12/22.
//

import Core
import Combine
import Game
 
public struct GetFavoritesRepository<
    FavoriteLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    FavoriteLocaleDataSource.Response == GameModuleEntity,
    Transformer.Response == [GameResult],
    Transformer.Entity == [GameModuleEntity],
Transformer.Domain == [DetailGameDomainModel] {
    public typealias Request = Any
    public typealias Response = [DetailGameDomainModel]
    
    private let _localeDataSource: FavoriteLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: FavoriteLocaleDataSource,
        mapper: Transformer) {
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[DetailGameDomainModel], Error> {
        return _localeDataSource.list(request: nil)
          .flatMap { result -> AnyPublisher<[DetailGameDomainModel], Error> in
            return _localeDataSource.list(request: nil)
              .map { _mapper.transformEntityToDomain(entity: $0) }
              .eraseToAnyPublisher()
          }.eraseToAnyPublisher()
    }
  
    public func execute(request: Request?, keyword: String) -> AnyPublisher<[DetailGameDomainModel], Error> {
      return _localeDataSource.list(request: nil)
        .flatMap { result -> AnyPublisher<[DetailGameDomainModel], Error> in
          return _localeDataSource.list(request: nil)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}
