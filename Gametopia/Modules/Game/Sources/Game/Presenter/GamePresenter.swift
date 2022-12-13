//
//  File.swift
//  
//
//  Created by Patricia Fiona on 14/12/22.
//

import Foundation
import Combine

public class GamePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let useCase: GameUseCase

  @Published public var games: [DetailGameDomainModel] = []
  @Published public var gameUpdated: DetailGameDomainModel?
  
  @Published public var errorMessage: String = ""
  @Published public var loadingState: Bool = false
  @Published public var discoveryLoadingState: Bool = false
  
  public init(useCase: GameUseCase) {
    self.useCase = useCase
  }
  
  public func getGames() {
    discoveryLoadingState = true
    useCase.getFewDiscoveryGame()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Get Discovey from API ERROR: \(completion)")
        case .finished:
          self.discoveryLoadingState = false
          print("Get Discovey from API FINISHED")
        }
      }, receiveValue: { games in
        self.games = games
      })
      .store(in: &cancellables)
  }
  
}
