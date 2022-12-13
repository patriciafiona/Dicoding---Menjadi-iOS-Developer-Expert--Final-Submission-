//
//  Injection.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import RealmSwift
import UIKit

import Core
import Game
import Favorite
import Search

final class Injection: NSObject {
  
  var realm: Realm! = try! Realm()
  
  private func provideRepository() -> GametopiaRepositoryProtocol {
    let realm = try? Realm()

    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return GametopiaRepository.sharedInstance(locale, remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }

  func provideDetail(id: Int, isAdd: Bool = false) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, id: id, isAdd: isAdd)
  }
  
  func provideDetailGenre(id: Int) -> DetailGenreUseCase {
    let repository = provideRepository()
    return DetailGenreInteractor(repository: repository, id: id)
  }
  
  func provideDiscoveryByRating() -> DiscoveryByRatingUseCase {
    let repository = provideRepository()
    return DiscoveryByRatingInteractor(repository: repository)
  }
  
  func provideMyFavorites() -> MyFavoriteUseCase {
    let repository = provideRepository()
    return MyFavoritesInteractor(repository: repository)
  }
  
  //From Module
  func provideDiscoveryGame<U: UseCase>() -> U where U.Request == Any, U.Response == [GameDomainModel] {
      let locale = GetGamesLocaleDataSource(realm: realm)
      let remote = GetGamesRemoteDataSource(endpoint: Endpoints.Gets.games.url)
      let mapper = GameTransformer()
      let repository = GetGamesRepository(
          localeDataSource: locale,
          remoteDataSource: remote,
          mapper: mapper)
      return Interactor(repository: repository) as! U
  }
  
  func provideFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == [Favorite.DetailGameDomainModel] {
      let locale = GetFavoritesLocaleDataSource(realm: realm)
      let mapper = FavoriteTransformer()
      let repository = GetFavoritesRepository(
          localeDataSource: locale,
          mapper: mapper)
      return Interactor(repository: repository) as! U
  }
  
  func provideSearch<U: UseCase>() -> U where U.Request == Any, U.Response == [SearchDomainModel] {
      let remote = GetSearchRemoteDataSource(endpoint: Endpoints.Gets.games.url)
      let mapper = SearchTransformer()
      let repository = GetSearchRepository(
          remoteDataSource: remote,
          mapper: mapper)
      return Interactor(repository: repository) as! U
  }

}
