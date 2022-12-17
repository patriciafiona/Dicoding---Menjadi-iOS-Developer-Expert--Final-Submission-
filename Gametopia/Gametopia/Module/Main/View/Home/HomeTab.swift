//
//  HomeTab.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI
import Lottie

import Core
import Game
import Favorite
import Genre
import Developer

struct HomeTab: View {
  @ObservedObject var genrePresenter: GenrePresenter
  @ObservedObject var favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritesRepository<GetFavoritesLocaleDataSource, FavoriteTransformer>>>
  @ObservedObject var developerPresenter: GetListPresenter<Any, DeveloperDomainModel, Interactor<Any, [DeveloperDomainModel], GetDevelopersRepository<GetDevelopersLocaleDataSource, GetDevelopersRemoteDataSource, DeveloperTransformer>>>
  @ObservedObject var gamePresenter: GamePresenter
  @State var game: Game.DetailGameDomainModel?
  
  var body: some View {
    let router = HomeRouter(gamePresenter: gamePresenter, favoritePresenter: favoritePresenter, genrePresenter: genrePresenter)
    
    ZStack {
      if gamePresenter.discoveryLoadingState {
        ZStack{
          LottieView(
            name: "loading",
            loopMode: .loop
          )
        }
        .frame(
          minWidth: 0,
          maxWidth: .infinity,
          minHeight: 0,
          maxHeight: .infinity,
          alignment: .topLeading
        )
        .background(.black)
        
      } else {
        ScrollView(.vertical, showsIndicators: false){
          VStack(alignment: .leading){
            //Top bar section
            Group{
              HStack{
                Text("Gametopia")
                  .font(
                    Font.custom(
                      "VerminVibesV",
                      size: 24
                    )
                  )
                Spacer()
                Image("user")
                  .resizable()
                  .frame(width: 40, height: 40)
                  .clipShape(Circle())
              }
            }
            
            Spacer().frame(height: 20)
            
            //Home carousel section
            HomeCarousel()
            
            Spacer().frame(height: 20)
            
            //Discovery section
            Group{
              HStack {
                TitleSubtitle(title: "Discovery", subtitle: "Based on best rating")
                Spacer()
                
                NavigationLink(
                  destination: router.makeDiscoverByRatingView()
                ) {
                  Image(
                    systemName: "arrow.right.circle"
                  )
                  .tint(Color.yellow)
                }.buttonStyle(PlainButtonStyle())
              }
              
              ScrollView(.horizontal, showsIndicators: false){
                if gamePresenter.discoveryLoadingState{
                  LazyHStack{
                    ForEach(1..<5) { index in
                      //Empty Skeleton View
                      Rectangle()
                      .skeleton(with: gamePresenter.discoveryLoadingState)
                      .shape(type: .rectangle)
                      .appearance(type: .solid(color: .yellow, background: .black))
                      .frame(
                        width: 200,
                        height: 230
                      )
                    }
                  }
                }else{
                  LazyHStack{
                    ForEach(
                      gamePresenter.games,
                      id: \.id
                    ) { game in
                      ZStack {
                        NavigationLink(
                          destination: router.makeDetailView(for: game.id ?? 0)
                        ) {
                          GameItem(
                            favoritePresenter: favoritePresenter,
                            gamePresenter: gamePresenter,
                            game: game
                          )
                        }.buttonStyle(PlainButtonStyle())
                       }.padding(8)
                    }
                  }
                }
              }.frame(maxHeight: 235)
            }
            
            Spacer().frame(height: 20)
            
            //Genre section
            Group{
              TitleSubtitle(title: "Genres", subtitle: "Find your game genre here")
              GenreGridView(presenter: self.genrePresenter, router: router)
            }
            
            
            Spacer().frame(height: 20)
            
            //Developer section
            Group{
              TitleSubtitle(title: "Developers", subtitle: "Find your favorite developer here")
              
              ScrollView(.vertical, showsIndicators: false){
                LazyVStack{
                  ForEach(
                    self.developerPresenter.list,
                    id: \.id
                  ) { developer in
                    DeveloperItem(developer: developer, presenter: developerPresenter)
                  }
                }
              }.frame(maxHeight: 800)
            }
            
          }
          .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
          .padding(EdgeInsets.init(top: 16, leading: 20, bottom: 50, trailing: 20))
        }
      }
    }.onAppear {
      self.gamePresenter.getGames()
      self.genrePresenter.getGenres()
      self.developerPresenter.getList(request: nil)
      
      self.gamePresenter.objectWillChange.send()
      self.genrePresenter.objectWillChange.send()
      self.developerPresenter.objectWillChange.send()
      
      //tab bar appearance
      let tabBarAppearance = UITabBarAppearance()
      tabBarAppearance.configureWithDefaultBackground()
      UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    .navigationBarTitle("")
    .navigationBarHidden(true)
  }
}

struct HomeCarousel: View {
  @State private var orientation = UIDeviceOrientation.unknown
  
  var body: some View {
    Group {
        if orientation.isLandscape {
          HomeCarouselContent()
          .frame(width: UIScreen.main.bounds.width - 150, height: 300, alignment: .center)
          .cornerRadius(20)
        } else {
          HomeCarouselContent()
          .frame(width: UIScreen.main.bounds.width - 40, height: 200, alignment: .center)
          .cornerRadius(20)
        }
    }
    .onRotate { newOrientation in
        orientation = newOrientation
    }
  }
}

struct HomeCarouselContent: View {
  var body: some View {
    GeometryReader { geometry in
      ImageCarouselTemplate(numberOfImages: 5) {
        Image("home_banner_01")
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .clipped()
        Image("home_banner_02")
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .clipped()
        Image("home_banner_03")
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .clipped()
        Image("home_banner_04")
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .clipped()
        Image("home_banner_05")
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .clipped()
      }
    }
  }
}

struct GenreGridView: View{
  @State var presenter: GenrePresenter
  var router: HomeRouter
  
  var body: some View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    ScrollView {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(presenter.genres, id: \.id) { genre in
              ZStack {
                NavigationLink(
                  destination: router.makeDetailGenreView(for: genre.id ?? 0 )
                ) {
                  GenreItem(genre: genre)
                }
               }.buttonStyle(PlainButtonStyle())
              
            }
        }
        .padding(.horizontal)
    }
    .frame(maxHeight: 500)
  }
}
