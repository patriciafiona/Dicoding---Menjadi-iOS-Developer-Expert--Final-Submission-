//
//  File.swift
//  
//
//  Created by Patricia Fiona on 14/12/22.
//

import Foundation
import Combine

public protocol GameUseCase {
  func getFewDiscoveryGame() -> AnyPublisher<[DetailGameDomainModel], Error>
  func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<[GameDomainModel], Error>
  func getDetailGame(id: Int) -> AnyPublisher<DetailGameDomainModel, Error>
}

public class GameInteractor: GameUseCase {
  private let repository: GetGamesRepository
  private var isAdd: Bool = false
  
  public init(repository: GetGamesRepository, isAdd: Bool) {
    self.repository = repository
    self.isAdd = isAdd
  }
  
  public func getFewDiscoveryGame() -> AnyPublisher<[DetailGameDomainModel], Error> {
    return repository.getFewDiscoveryGame()
  }
  
  public func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<[GameDomainModel], Error> {
    return repository.getAllDiscoveryGame(sortFromBest: sortFromBest)
  }

  public func getDetailGame(id: Int) -> AnyPublisher<DetailGameDomainModel, Error> {
    return repository.getGameDetail(id: id, isAdd: self.isAdd)
  }
  
}

