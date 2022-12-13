//
//  GametopiaApp.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI
import Core

import Game
import Favorite
import Search

@main
struct GametopiaApp: App {
  @Environment(\.scenePhase) private var scenePhase
  
  var body: some Scene {
    WindowGroup {
      let gameUseCase: GameInteractor = Injection.init().provideGame() as! GameInteractor
      let gamePresenter = GamePresenter(useCase: gameUseCase)
      
      let favoriteUseCase: Interactor<
          Any,
          [Favorite.DetailGameDomainModel],
          GetFavoritesRepository<
              GetFavoritesLocaleDataSource,
              FavoriteTransformer
          >
        > = Injection.init().provideFavorite()
      let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
      
      let seachUseCase: Interactor<
          Any,
          [SearchDomainModel],
          GetSearchRepository<
              GetSearchRemoteDataSource,
              SearchTransformer>
      > = Injection.init().provideSearch()
      let searchPresenter = GetListPresenter(useCase: seachUseCase)
      
      SplashView()
        .environmentObject(gamePresenter)
        .environmentObject(favoritePresenter)
        .environmentObject(searchPresenter)
    }
    .onChange(of: scenePhase) { phase in
      if phase == .background {
        //perform cleanup
      }
    }
  }
}
