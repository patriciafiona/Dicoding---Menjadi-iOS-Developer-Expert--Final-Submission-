//
//  GenreDetailView.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import SwiftUI
import Kingfisher
import SkeletonUI

import Core
import Genre
import Game
import Favorite

struct DetailGenreView: View {
  @ObservedObject var presenter: GenrePresenter
  @ObservedObject var gamePresenter: GamePresenter
  @ObservedObject var favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritesRepository<GetFavoritesLocaleDataSource, FavoriteTransformer>>>
  var genreId: Int
  
  init(presenter: GenrePresenter, gamePresenter: GamePresenter, genreId: Int, favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritesRepository<GetFavoritesLocaleDataSource, FavoriteTransformer>>>) {
      self.presenter = presenter
      self.gamePresenter = gamePresenter
      self.genreId = genreId
      self.favoritePresenter = favoritePresenter
      
      let navBarAppearance = UINavigationBar.appearance()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      navBarAppearance.barTintColor = .black
  }
  
  var body: some View {
    RootGenreContent(gamePresenter: gamePresenter, presenter: presenter, favoritePresenter: favoritePresenter, genreId: genreId)
  }
}

struct RootGenreContent: View{
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var gamePresenter: GamePresenter
    @ObservedObject var presenter: GenrePresenter
    @ObservedObject var favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritesRepository<GetFavoritesLocaleDataSource, FavoriteTransformer>>>
    var genreId: Int
    
    var body: some View{
      let router = DetailGenreRouter(presenter: gamePresenter, favoritePresenter: favoritePresenter)
        NavigationView {
            ScrollView{
                VStack(alignment: .leading) {
                    ZStack{
                        GeometryReader { geometry in
                          KFImage.url(URL(string: presenter.detailGenre?.imageBackground ?? "" ))
                                .placeholder {
                                    Image("gametopia_icon")
                                        .resizable()
                                        .scaledToFit()
                                }
                                .cacheOriginalImage()
                                .fade(duration: 0.25)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .edgesIgnoringSafeArea(.all)
                                .frame(maxWidth: geometry.size.width,
                                       maxHeight: geometry.size.height)
                                .mask(
                                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                                )
                                .overlay{
                                  HeaderGenreOverlay(name: presenter.detailGenre?.name, gamesCount: presenter.detailGenre?.gamesCount)
                                    .skeleton(with: presenter.detailGenre?.name == nil)
                                        .shape(type: .rectangle)
                                        .appearance(type: .solid(color: .yellow, background: .black))
                                }
                        }
                        
                    }
                    .frame(height: 450.0)
                    
                    Text("About")
                        .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
                        .foregroundColor(.yellow)
                        .skeleton(with: presenter.detailGenre?.desc == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                    
                  HTMLStringView(htmlContent: presenter.detailGenre?.desc ?? "No description")
                        .frame(minHeight: 200, maxHeight: 400)
                        .padding(.bottom, 20)
                        .skeleton(with: presenter.detailGenre?.desc == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                        .multiline(lines: 20, scales: [1: 0.5])
                    
                    Text("Popular Games")
                        .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
                        .foregroundColor(.yellow)
                        .skeleton(with: presenter.detailGenre?.games == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                    
                    if(presenter.detailGenre?.games != nil){
                        LazyVStack(alignment: .leading){
                          ForEach(presenter.detailGenre!.games, id: \.id){ game in
                            ZStack{
                              NavigationLink(
                                destination: router.makeDetailView(for: game.id ?? 0)
                              ) {
                                Text(game.name)
                                  .foregroundColor(.white)
                                  .font(.system(size: 16))
                                  .underline()
                                  .padding(.bottom, 10)
                                }.buttonStyle(PlainButtonStyle())
                              }
                          }
                        }
                        .skeleton(with: presenter.detailGenre?.games == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                    }
                }
                .padding(10)
                .navigationBarTitle("Genre Details")
                .padding(.bottom, 50)
            }
            .background(Color.black)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left.circle")
                                .foregroundColor(.yellow)
                            Text("Go Back")
                                .foregroundColor(.yellow)
                        }
                    })
        }
        .navigationBarBackButtonHidden(true)
        .phoneOnlyStackNavigationView()
        .statusBar(hidden: true)
        .onAppear {
          self.presenter.getDetailGenre(id: genreId )
          self.presenter.objectWillChange.send()
        }
    }
}

struct HeaderGenreOverlay: View{
    var name: String?
    var gamesCount: Int?
    
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(name ?? "Unknown Name")
                    .font(Font.custom("EvilEmpire", size: 32, relativeTo: .title))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5)
                
                Text("Total games: \(gamesCount ?? 0)")
                    .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                    .font(.caption)
            }
            .padding()
        }
    }
}

