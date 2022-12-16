//
//  GametopiaRepositories.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import Combine
 
protocol GametopiaRepositoryProtocol {
  func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<[GameModel], Error>
  func getFewDiscoveryGame() -> AnyPublisher<[DetailGameModel], Error>
  
  func getGameDetail(id: Int, isAdd: Bool) -> AnyPublisher<DetailGameModel, Error>
  func updateFavoriteGame(id: Int, isFavorite: Bool) -> AnyPublisher<DetailGameModel, Error>
  
  func getAllFavoriteGame() -> AnyPublisher<[DetailGameModel], Error>
}

final class GametopiaRepository: NSObject {
  typealias GametopiaInstance = (LocaleDataSource, RemoteDataSource) -> GametopiaRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource

  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }

  static let sharedInstance: GametopiaInstance = { localeRepo, remoteRepo in
    return GametopiaRepository(locale: localeRepo, remote: remoteRepo)
  }

}

extension GametopiaRepository: GametopiaRepositoryProtocol {
  
  func getAllFavoriteGame() -> AnyPublisher<[DetailGameModel], Error> {
    return self.locale.getAllFavoriteGames()
      .flatMap { result -> AnyPublisher<[DetailGameModel], Error> in
        return self.locale.getAllFavoriteGames()
          .flatMap { _ in self.locale.getAllFavoriteGames()
            .map { DetailGameMapper.mapDetailGameEntitiesToDomains(input: $0) }
          }
          .eraseToAnyPublisher()
      }.eraseToAnyPublisher()
  }
  
  func updateFavoriteGame(id: Int, isFavorite: Bool) -> AnyPublisher<DetailGameModel, Error> {
    return self.locale.getDetailGame(id: id )
      .flatMap { result -> AnyPublisher<DetailGameModel, Error> in
        return self.remote.getGameDetails(id: id)
          .map { DetailGameMapper.mapDetailGameResponsesToEntities(input: $0) }
          .flatMap { res in
            self.locale.updateFavoriteGames(id: res.id, isFavorite: isFavorite)
          }
          .filter { $0 }
          .flatMap { _ in self.locale.getDetailGame(id: id )
            .map { DetailGameMapper.mapDetailGameEntityToDomain(input: $0) }
          }
          .eraseToAnyPublisher()
      }.eraseToAnyPublisher()
  }

  func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<[GameModel], Error> {
    return self.remote.getAllDiscoveryGame(sortFromBest: sortFromBest)
      .flatMap { result -> AnyPublisher<[GameModel], Error> in
        return self.remote.getAllDiscoveryGame(sortFromBest: sortFromBest )
          .flatMap { _ in self.remote.getAllDiscoveryGame(sortFromBest: sortFromBest )
            .map { GameMapper.mapGameResponsesToDomains(input: $0) }
          }
          .eraseToAnyPublisher()
      }.eraseToAnyPublisher()
  }
  
  func getFewDiscoveryGame() -> AnyPublisher<[DetailGameModel], Error> {
    return self.locale.getBestRatingGames()
      .flatMap { result -> AnyPublisher<[DetailGameModel], Error> in
        if result.isEmpty {
          return self.remote.getFewDiscoveryGame()
            .map { DetailGameMapper.mapDetailGameResponseToEntities(input: $0) }
            .flatMap { self.locale.addGames(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getBestRatingGames()
              .map { DetailGameMapper.mapDetailGameEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getBestRatingGames()
            .map { DetailGameMapper.mapDetailGameEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getGameDetail(id: Int, isAdd: Bool = false) -> AnyPublisher<DetailGameModel, Error> {
    return self.locale.getDetailGame(id: id )
      .flatMap { result -> AnyPublisher<DetailGameModel, Error> in
        if result.desc == "" {
          return self.remote.getGameDetails(id: id)
            .map { DetailGameMapper.mapDetailGameResponsesToEntities(input: $0) }
            .flatMap { res in
              if(isAdd){
                return self.locale.addGame(from: res)
              }else{
                return self.locale.updateGames(gameEntity: res)
              }
            }
            .filter { $0 }
            .flatMap { _ in self.locale.getDetailGame(id: id )
              .map { DetailGameMapper.mapDetailGameEntityToDomain(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getDetailGame(id: id )
            .map { DetailGameMapper.mapDetailGameEntityToDomain(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
}
