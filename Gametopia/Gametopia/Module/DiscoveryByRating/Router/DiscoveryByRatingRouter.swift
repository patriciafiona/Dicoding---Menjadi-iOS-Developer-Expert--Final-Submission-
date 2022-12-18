//
//  DiscoveryByRatingRouter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 17/12/22.
//

import Foundation
import SwiftUI

import Core
import Game
import Favorite

class DiscoveryByRatingRouter {
  
  @ObservedObject var presenter: GamePresenter
  @ObservedObject var favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritesRepository<GetFavoritesLocaleDataSource, FavoriteTransformer>>>
  
  init(presenter: GamePresenter, favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritesRepository<GetFavoritesLocaleDataSource, FavoriteTransformer>>>) {
    self.presenter = presenter
    self.favoritePresenter = favoritePresenter
  }

  func makeDetailView(for id: Int, isAdd: Bool = false) -> some View {
    let detailUseCase = Injection.init().provideDetail(isAdd: true)
    return DetailView(presenter: presenter, favoritePresenter: favoritePresenter, gameId: id, isAdd: isAdd)
  }
  
}
