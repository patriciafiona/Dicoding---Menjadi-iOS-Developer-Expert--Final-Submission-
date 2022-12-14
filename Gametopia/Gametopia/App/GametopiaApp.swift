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
import Genre
import Developer

@main
struct GametopiaApp: App {
  @Environment(\.scenePhase) private var scenePhase
  
  var body: some Scene {
    WindowGroup {
      let genreUseCase: GenreInteractor = Injection.init().provideGenre()
      let genrePresenter = GenrePresenter(useCase: genreUseCase)
      
      let gameUseCase: GameInteractor = Injection.init().provideGame()
      let gamePresenter = GamePresenter(useCase: gameUseCase)
      
      let developerUseCase: Interactor<
          Any,
          [DeveloperDomainModel],
          GetDevelopersRepository<
              GetDevelopersLocaleDataSource,
              GetDevelopersRemoteDataSource,
              DeveloperTransformer
          >
        > = Injection.init().provideDeveloper()
      let developerPresenter = GetListPresenter(useCase: developerUseCase)
      
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
        .environmentObject(genrePresenter)
        .environmentObject(favoritePresenter)
        .environmentObject(searchPresenter)
        .environmentObject(developerPresenter)
    }
    .onChange(of: scenePhase) { phase in
      if phase == .background {
        //perform cleanup
      }
    }
  }
}
