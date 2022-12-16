//
//  File.swift
//  
//
//  Created by Patricia Fiona on 15/12/22.
//

import Foundation
import RealmSwift

public class DeveloperModuleEntity: Object {
  @Persisted(primaryKey: true) public var id = ""
  @Persisted public dynamic var name: String = ""
  @Persisted public dynamic var slug: String = ""
  @Persisted public dynamic var gameCount: Int = 0
  @Persisted public dynamic var imageBackground: String = ""
  @Persisted public var games: List<GameInDeveloperEntity> = List<GameInDeveloperEntity>()
}

public class GameInDeveloperEntity: Object {
  @Persisted(primaryKey: true) public var id = ""
  @Persisted public dynamic var name: String = ""
  @Persisted public dynamic var slug: String = ""
  @Persisted public dynamic var added: Int = 0
  
  @Persisted(originProperty: "games") public var assignee: LinkingObjects<DeveloperModuleEntity>
}
