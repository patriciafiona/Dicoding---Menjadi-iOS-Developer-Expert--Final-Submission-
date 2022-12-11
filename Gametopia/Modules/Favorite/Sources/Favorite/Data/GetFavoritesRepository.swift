//
//  File.swift
//  
//
//  Created by Patricia Fiona on 11/12/22.
//

import Core
import Combine
 
public struct GetFavoritesRepository<
    FavoriteLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    FavoriteLocaleDataSource.Response == FavoriteModuleEntity,
    RemoteDataSource.Response == [GameResult],
    Transformer.Response == [GameResult],
    Transformer.Entity == [FavoriteModuleEntity],
    Transformer.Domain == [FavoriteDomainModel] {
  
    public typealias Request = Any
    public typealias Response = [FavoriteDomainModel]
    
    private let _localeDataSource: FavoriteLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: FavoriteLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    // 4
    public func execute(request: Any?) -> AnyPublisher<[FavoriteDomainModel], Error> {
        return _localeDataSource.list(request: nil)
          .flatMap { result -> AnyPublisher<[FavoriteDomainModel], Error> in
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
}
