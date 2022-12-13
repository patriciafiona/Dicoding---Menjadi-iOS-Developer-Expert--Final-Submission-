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
}

public class GameInteractor: GameUseCase {
  private let repository: GetGamesRepository
  
  public init(repository: GetGamesRepository) {
    self.repository = repository
  }
  
  public func getFewDiscoveryGame() -> AnyPublisher<[DetailGameDomainModel], Error> {
    return repository.getFewDiscoveryGame()
  }

}

