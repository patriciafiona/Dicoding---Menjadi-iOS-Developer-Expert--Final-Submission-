//
//  File.swift
//  
//
//  Created by Patricia Fiona on 14/12/22.
//

import Foundation
import Combine

public protocol GenreUseCase {
  func getListGenres() -> AnyPublisher<[GenreDomainModel], Error>
  func getDetailGenre() -> AnyPublisher<GenreDomainModel, Error>
}

public class GenreInteractor: GenreUseCase {
  private let id: Int
  private let repository: GetGenresRepository
  
  public init(repository: GetGenresRepository, id: Int) {
    self.repository = repository
    self.id = id
  }
  
  public func getListGenres() -> AnyPublisher<[GenreDomainModel], Error> {
    return repository.getListGenres()
  }

  public func getDetailGenre() -> AnyPublisher<GenreDomainModel, Error> {
    return repository.getGenreDetail(id: id)
  }

}
