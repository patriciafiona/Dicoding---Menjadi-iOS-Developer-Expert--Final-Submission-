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

struct HomeView: View {
  @ObservedObject var homePresenter: HomePresenter
  @ObservedObject var favoritePresenter: GetListPresenter<Any, DetailGameDomainModel, Interactor<Any, [DetailGameDomainModel], GetFavoritesRepository<GetFavoritesLocaleDataSource, FavoriteTransformer>>>
  @ObservedObject var searchPresenter: GetListPresenter<Any, SearchDomainModel, Interactor<Any, [SearchDomainModel], GetSearchRepository<GetSearchRemoteDataSource, SearchTransformer>>>
  
  @State var tabSelection: Tabs = .tabHome
  
  enum Tabs{
      case tabHome, tabSearch, tabFavorite, tabProfile
  }
    var body: some View {
        NavigationView{
            TabView(selection: $tabSelection) {
              HomeTab(presenter: homePresenter)
                 .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                 }
                 .tag(Tabs.tabHome)
               SearchTab(presenter: searchPresenter)
                 .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                 }
                 .tag(Tabs.tabSearch)
                FavoriteTab(presenter: favoritePresenter)
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
