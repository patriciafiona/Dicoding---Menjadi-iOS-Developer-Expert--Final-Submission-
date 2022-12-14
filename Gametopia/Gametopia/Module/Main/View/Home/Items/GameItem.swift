//
//  GameItem.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import SwiftUI
import Kingfisher
import SkeletonUI

import Core
import Game
import Favorite

struct GameItem: View {
  @ObservedObject var favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritesRepository<GetFavoritesLocaleDataSource, FavoriteTransformer>>>
  @ObservedObject var gamePresenter: GamePresenter
  
  @State var game: Game.DetailGameDomainModel
  @State private var _isFavorite: Bool = false
  
  private var scale: CGFloat {
      UIScreen.main.scale
  }
  
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        KFImage.url(URL(string: (game.backgroundImage) ?? ""))
            .placeholder {
                Image("gametopia_icon")
                    .resizable()
                    .scaledToFit()
            }
            .cacheOriginalImage()
            .resizable()
            .clipped()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 150)
            .cornerRadius(10)
            .skeleton(with: game.backgroundImage == nil)
            .shape(type: .rectangle)
            .appearance(type: .solid(color: .yellow, background: .black))
        HStack{
          VStack(alignment: .leading){
            if(game.released != ""){
              Text("Released on \(dateFormat(dateTxt: game.released!))")
                .font(Font.system(size: 12))
                .foregroundColor(
                  Color(red: 209/255, green: 209/255, blue: 209/255)
                )
                .skeleton(with: game.released == nil)
                .shape(type: .rectangle)
                .appearance(type: .solid(color: .yellow, background: .black))
            }else{
              Text("Unknown released date")
                .font(Font.system(size: 12))
                .foregroundColor(
                  Color(red: 209/255, green: 209/255, blue: 209/255)
                )
                .skeleton(with: game.released == nil)
                .shape(type: .rectangle)
                .appearance(type: .solid(color: .yellow, background: .black))
            }
            
            Spacer().frame(height: 3)
            Text(game.name)
              .font(
                Font.custom("EvilEmpire", size: 16, relativeTo: .title)
              )
              .foregroundColor(.white)
              .lineLimit(2)
              .fixedSize(horizontal: false, vertical: true)
              .skeleton(with: game.name == nil)
              .shape(type: .rectangle)
              .appearance(type: .solid(color: .yellow, background: .black))
            HStack{
              Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .font(.system(size: 12))
              Text(String(format: "%.2f", game.rating!))
                .font(
                  Font.custom("EvilEmpire", size: 12)
                )
                .foregroundColor(.white)
            }
            .skeleton(with: game.rating == nil)
            .shape(type: .rectangle)
            .appearance(type: .solid(color: .yellow, background: .black))
          }
          Button(action: {
            _isFavorite = !_isFavorite
            favoritePresenter.updateFavorite(request: nil, id: game.id!, isFavorite: _isFavorite)
            gamePresenter.getGames()
          }) {
            Image(
              systemName: _isFavorite == true ? "heart.circle.fill" : "heart.circle"
            )
            .font(.system(size: 18))
            .foregroundColor(_isFavorite == true ? .red : .gray)
          }
        }
        .padding(10)
        Spacer()
      }
      .frame(
        width: 200,
        height: 230
      )
      .background(Color(red: 67/255, green: 67/255, blue: 67/255))
      .cornerRadius(10)
      .onAppear{
        _isFavorite = game.isFavorite ?? false
      }
    }
}
