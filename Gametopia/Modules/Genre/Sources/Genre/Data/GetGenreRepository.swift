//
//  File.swift
//  
//
//  Created by Patricia Fiona on 14/12/22.
//

import Foundation
import Core
import Combine

public class GetGenresRepository: NSObject {
  typealias GametopiaInstance = (GetGenresLocaleDataSource, GetGenresRemoteDataSource) -> GetGenresRepository
  
  let remote: GetGenresRemoteDataSource
  let locale: GetGenresLocaleDataSource
  
  public init(locale: GetGenresLocaleDataSource, remote: GetGenresRemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }
  
  func getListGenres() -> AnyPublisher<[GenreDomainModel], Error> {
    return self.locale.getGenres()
      .flatMap { result -> AnyPublisher<[GenreDomainModel], Error> in
        if result.isEmpty {
          return self.remote.getListGenres()
            .map { GenreTransformer.mapGenresResponsesToEntities(input: $0) }
            .flatMap { self.locale.addGenres(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getGenres()
              .map { GenreTransformer.mapGenresEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getGenres()
            .map { GenreTransformer.mapGenresEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getGenreDetail(id: Int) -> AnyPublisher<GenreDomainModel, Error> {
    return self.locale.getDetailGenre(id: id )
      .flatMap { result -> AnyPublisher<GenreDomainModel, Error> in
        if result.desc.elementsEqual("Unknown Description") {
          return self.remote.getGenreDetails(id: id)
            .map { GenreTransformer.mapGenresResponsesToEntity(input: $0) }
            .flatMap { res in
              self.locale.updateGenre(id: id, desc: res.desc)
            }
            .filter { $0 }
            .flatMap { _ in self.locale.getDetailGenre(id: id )
              .map { GenreTransformer.mapGenresEntityToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getDetailGenre(id: id )
            .map { GenreTransformer.mapGenresEntityToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
}
