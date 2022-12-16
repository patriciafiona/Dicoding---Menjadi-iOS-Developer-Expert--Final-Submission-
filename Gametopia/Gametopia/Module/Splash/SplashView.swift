//
//  SplashView.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI
import Core
import Favorite
import Search
import Game
import Genre
import Developer

struct SplashView: View {
  @State var pushNewView: Bool = false
  @EnvironmentObject var gamePresenter: GamePresenter
  @EnvironmentObject var genrePresenter: GenrePresenter
  @EnvironmentObject var favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritesRepository<GetFavoritesLocaleDataSource, FavoriteTransformer>>>
  @EnvironmentObject var searchPresenter: GetListPresenter<Any, SearchDomainModel, Interactor<Any, [SearchDomainModel], GetSearchRepository<GetSearchRemoteDataSource, SearchTransformer>>>
  @EnvironmentObject var developerPresenter: GetListPresenter<Any, DeveloperDomainModel, Interactor<Any, [DeveloperDomainModel], GetDevelopersRepository<GetDevelopersLocaleDataSource, GetDevelopersRemoteDataSource, DeveloperTransformer>>>
  
  var body: some View {
    NavigationView{
      NavigationLink(isActive: $pushNewView) {
        HomeView(
          gamePresenter: gamePresenter,
          genrePresenter: genrePresenter,
          favoritePresenter: favoritePresenter,
          searchPresenter: searchPresenter,
          developerPresenter: developerPresenter
        )
      } label: {
        SplashContent()
      }
      .onAppear {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
          pushNewView = true
        }
      }
    }
  }
}

struct SplashContent: View{
  @State var isAnimating = false
  var body: some View{
    VStack(alignment: .center){
      Spacer()
      Image("gametopia_icon")
        .resizable()
        .frame(width: 250.0, height: 250.0)
        .animation(
          Animation.easeInOut(duration: 1)
            .repeatForever(autoreverses: true),
          value: isAnimating
        ).onAppear(perform: {
          isAnimating = true
        })
      Spacer().frame(height: 50)
      Text("Gametopia")
        .font(
          Font.custom(
            "VerminVibesV",
            size: 40
          )
        )
        .foregroundColor(Color.white)
      Spacer()
    }
    .background(Color.black)
    .preferredColorScheme(.dark)
  }
}

struct SplashView_Previews: PreviewProvider {
  static var previews: some View {
    SplashView()
  }
}
