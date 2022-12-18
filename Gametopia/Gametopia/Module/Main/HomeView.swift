//
//  ContentView.swift
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

struct HomeView: View {
  @ObservedObject var gamePresenter: GamePresenter
  @ObservedObject var genrePresenter: GenrePresenter
  @ObservedObject var favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritesRepository<GetFavoritesLocaleDataSource, FavoriteTransformer>>>
  @ObservedObject var searchPresenter: GetListPresenter<Any, SearchDomainModel, Interactor<Any, [SearchDomainModel], GetSearchRepository<GetSearchRemoteDataSource, SearchTransformer>>>
  @ObservedObject var developerPresenter: GetListPresenter<Any, DeveloperDomainModel, Interactor<Any, [DeveloperDomainModel], GetDevelopersRepository<GetDevelopersLocaleDataSource, GetDevelopersRemoteDataSource, DeveloperTransformer>>>
  
  @State var tabSelection: Tabs = .tabHome
  
  enum Tabs{
      case tabHome, tabSearch, tabFavorite, tabProfile
  }
    var body: some View {
        NavigationView{
            TabView(selection: $tabSelection) {
              HomeTab(
                genrePresenter: genrePresenter,
                favoritePresenter: favoritePresenter,
                developerPresenter: developerPresenter,
                gamePresenter: gamePresenter
              )
                 .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                 }
                 .tag(Tabs.tabHome)
               SearchTab(
                presenter: searchPresenter,
                genrePresenter: genrePresenter, favoritePresenter: favoritePresenter,
                gamePresenter: gamePresenter
               )
                 .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                 }
                 .tag(Tabs.tabSearch)
                FavoriteTab(
                  presenter: favoritePresenter,
                  genrePresenter: genrePresenter,
                  gamePresenter: gamePresenter
                )
                  .tabItem {
                     Image(systemName: "heart.circle.fill")
                     Text("Favorites")
                  }
                  .tag(Tabs.tabFavorite)
                ProfileTab()
                  .tabItem {
                     Image(systemName: "person.circle")
                     Text("Profile")
                  }
                  .tag(Tabs.tabProfile)
            }
            .accentColor(.yellow)
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
    }
}
