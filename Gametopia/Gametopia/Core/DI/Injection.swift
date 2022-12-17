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
import Genre
import Developer

final class Injection: NSObject {
  
  var realm: Realm! = try! Realm()
  
  //From Module
  func provideGame() -> GameInteractor {
    let repository = GetGamesRepository(locale: GetGamesLocaleDataSource(realm: realm), remote: GetGamesRemoteDataSource())
    return GameInteractor(repository: repository, isAdd: false)
  }
  
  func provideDetail(isAdd: Bool = false) -> GameInteractor {
    let repository = GetGamesRepository(locale: GetGamesLocaleDataSource(realm: realm), remote: GetGamesRemoteDataSource())
    return GameInteractor(repository: repository, isAdd: isAdd)
  }
  
  func provideGenre() -> GenreInteractor {
    let repository = GetGenresRepository(locale: GetGenresLocaleDataSource(realm: realm), remote: GetGenresRemoteDataSource())
    return GenreInteractor(repository: repository, id: 0) //default value for id
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
  
  func provideDeveloper<U: UseCase>() -> U where U.Request == Any, U.Response == [DeveloperDomainModel] {
      let locale = GetDevelopersLocaleDataSource(realm: realm)
      let remote = GetDevelopersRemoteDataSource(endpoint: Endpoints.Gets.developers.url)
      let mapper = DeveloperTransformer()
      let repository = GetDevelopersRepository(
          localeDataSource: locale,
          remoteDataSource: remote,
          mapper: mapper)
      return Interactor(repository: repository) as! U
  }

}
