//
//  HomeRouter.swift
//  Gametopia
//
//  Created by Patricia Fiona on 16/12/22.
//

import Foundation
import SwiftUI

import Core
import Game
import Favorite
import Genre

public class HomeRouter {
  @ObservedObject var gamePresenter: GamePresenter
  @ObservedObject var favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritesRepository<GetFavoritesLocaleDataSource, FavoriteTransformer>>>
  @ObservedObject var genrePresenter: GenrePresenter
  
  init(gamePresenter: GamePresenter, favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritesRepository<GetFavoritesLocaleDataSource, FavoriteTransformer>>>, genrePresenter: GenrePresenter) {
    self.gamePresenter = gamePresenter
    self.favoritePresenter = favoritePresenter
    self.genrePresenter = genrePresenter
  }
  
  func makeDetailView(for id: Int) -> some View {
    return DetailView(presenter: gamePresenter, favoritePresenter: favoritePresenter, gameId: id)
  }
  
  func makeDiscoverByRatingView() -> some View {
    return DiscoveryByRatingView(presenter: gamePresenter, favoritePresenter: favoritePresenter)
  }
  
  func makeDetailGenreView(for id: Int) -> some View {
    return DetailGenreView(
      presenter: genrePresenter,
      gamePresenter: gamePresenter,
      genreId: id,
      favoritePresenter: favoritePresenter
    )
  }
  
}
