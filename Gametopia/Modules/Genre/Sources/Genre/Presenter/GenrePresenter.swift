//
//  File.swift
//  
//
//  Created by Patricia Fiona on 14/12/22.
//

import SwiftUI
import Combine

public class GenrePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let useCase: GenreUseCase

  @Published public var genres: [GenreDomainModel] = []
  @Published public var detailGenre: GenreDomainModel? = nil
  
  @Published public var errorMessage: String = ""
  @Published public var loadingState: Bool = false
  
  public init(useCase: GenreUseCase) {
    self.useCase = useCase
  }
  
  public func getGenres() {
    loadingState = true
    useCase.getListGenres()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Get Genre ERROR: \(completion)")
        case .finished:
          self.loadingState = false
          print("Get Genre FINISHED")
        }
      }, receiveValue: { genres in
        self.genres = genres
      })
      .store(in: &cancellables)
  }
  
  public func getDetailGenre() {
    loadingState = true
    useCase.getDetailGenre()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
          print("Get Detail Genre from API ERROR: \(completion)")
        case .finished:
          print("Get Detail Genre from API Success")
          self.loadingState = false
        }
      }, receiveValue: { detail in
        self.detailGenre = detail
      })
      .store(in: &cancellables)
  }
  
}
