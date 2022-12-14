//
//  File.swift
//  
//
//  Created by Patricia Fiona on 14/12/22.
//

import Foundation
import RealmSwift

class GenreModuleEntity: Object {
  @Persisted(primaryKey: true) public var id = 0
  @Persisted public var name: String = ""
  @Persisted public var slug: String = ""
  @Persisted public var gameCount: Int = 0
  @Persisted public var imageBackground: String = ""
  @Persisted public var games: List<GameInGenreEntity>
  
  //Additional that get fron detail genre
  @Persisted public dynamic var desc: String = "Unknown Description"
}

class GameInGenreEntity: Object {
  @Persisted(primaryKey: true) public var id = ""
  @Persisted public dynamic var name: String = ""
  @Persisted public dynamic var slug: String = ""
  @Persisted public dynamic var added: Int = 0
}
