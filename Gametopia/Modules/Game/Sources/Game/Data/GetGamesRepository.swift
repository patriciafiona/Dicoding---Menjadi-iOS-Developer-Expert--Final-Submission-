//
//  File.swift
//  
//
//  Created by Patricia Fiona on 11/12/22.
//

import Foundation
import Core
import Combine

public class GetGamesRepository: NSObject {
  typealias GametopiaInstance = (GetGamesLocaleDataSource, GetGamesRemoteDataSource) -> GetGamesRepository

  let remote: GetGamesRemoteDataSource
  let locale: GetGamesLocaleDataSource

  public init(locale: GetGamesLocaleDataSource, remote: GetGamesRemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }
  
  func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<[GameDomainModel], Error> {
    return self.remote.getAllDiscoveryGame(sortFromBest: sortFromBest)
      .flatMap { result -> AnyPublisher<[GameDomainModel], Error> in
        return self.remote.getAllDiscoveryGame(sortFromBest: sortFromBest )
          .flatMap { _ in self.remote.getAllDiscoveryGame(sortFromBest: sortFromBest )
            .map { GameTransformer.mapGameResponsesToDomains(input: $0) }
          }
          .eraseToAnyPublisher()
      }.eraseToAnyPublisher()
  }
  
  func getFewDiscoveryGame() -> AnyPublisher<[DetailGameDomainModel], Error> {
    return self.locale.getBestRatingGames()
      .flatMap { result -> AnyPublisher<[DetailGameDomainModel], Error> in
        if result.isEmpty {
          return self.remote.getFewDiscoveryGame()
            .map { DetailGameTransformer.mapDetailGameResponseToEntities(input: $0) }
            .flatMap { self.locale.addGames(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getBestRatingGames()
              .map { DetailGameTransformer.mapDetailGameEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getBestRatingGames()
            .map { DetailGameTransformer.mapDetailGameEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getGameDetail(id: Int, isAdd: Bool = false) -> AnyPublisher<DetailGameDomainModel, Error> {
    return self.locale.getDetailGame(id: id )
      .flatMap { result -> AnyPublisher<DetailGameDomainModel, Error> in
        if result.desc == "" {
          return self.remote.getGameDetails(id: id)
            .map { DetailGameTransformer.mapDetailGameResponsesToEntities(input: $0) }
            .flatMap { res in
              if(isAdd){
                return self.locale.addGame(from: res )
              }else{
                return self.locale.updateGames(gameEntity: res)
              }
            }
            .filter { $0 }
            .flatMap { _ in self.locale.getDetailGame(id: id )
              .map { DetailGameTransformer.mapDetailGameEntityToDomain(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getDetailGame(id: id )
            .map { DetailGameTransformer.mapDetailGameEntityToDomain(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

}
