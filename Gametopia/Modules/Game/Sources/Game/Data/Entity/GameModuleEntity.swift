//
//  File.swift
//  
//
//  Created by Patricia Fiona on 11/12/22.
//

import RealmSwift
import Foundation

public class GameModuleEntity: Object {
  @Persisted(primaryKey: true) public var id = 0
  @Persisted public var isFavorite: Bool = false
  @Persisted public var slug = ""
  @Persisted public var name = ""
  @Persisted public var nameOriginal = ""
  @Persisted public var desc = ""
  @Persisted public var released = ""
  @Persisted public var updated: String = ""
  @Persisted public var backgroundImage: String = ""
  @Persisted public var backgroundImageAdditional: String = ""
  @Persisted public var website: String = ""
  @Persisted public var rating: Double = 0.0
  @Persisted public var added: Int = 0
  @Persisted public var playtime: Int = 0
  @Persisted public var achievementsCount: Int = 0
  @Persisted public var ratingsCount: Int = 0
  @Persisted public var suggestionsCount: Int = 0
  @Persisted public var reviewsCount: Int = 0
  @Persisted public var parentPlatforms: List<PlatformModuleEntity> = List<PlatformModuleEntity>()
  @Persisted public var platforms: List<DetailPlatformModuleEntity> = List<DetailPlatformModuleEntity>()
  @Persisted public var stores: List<StoreDetailsModuleEntity> = List<StoreDetailsModuleEntity>()
  @Persisted public var developers: List<DeveloperInDetailsModuleEntity> = List<DeveloperInDetailsModuleEntity>()
  @Persisted public var genres: List<GenreInDetailsModuleEntity> = List<GenreInDetailsModuleEntity>()
  @Persisted public var tags: List<TagModuleEntity> = List<TagModuleEntity>()
  @Persisted public var publishers: List<PublisherModuleEntity> = List<PublisherModuleEntity>()
  @Persisted public var descriptionRaw: String = ""
}

public class PlatformModuleEntity: Object {
  @Persisted(primaryKey: true) public var id = UUID()
  @Persisted public var name: String = ""
  @Persisted public var slug: String = ""
}

public class DetailPlatformModuleEntity: Object{
  @Persisted(primaryKey: true) public var id = UUID()
  @Persisted public var platform: PlatformDetailsModuleEntity? = nil
  @Persisted public var releasedAt: String = ""
  @Persisted public var requirements: PlatformRequirementModuleEntity? = nil
}

public class PlatformDetailsModuleEntity: Object{
  @Persisted(primaryKey: true) public var id = UUID()
    @Persisted public var name: String? = ""
    @Persisted public var slug: String? = ""
    @Persisted public var gamesCount: Int? = 0
    @Persisted public var image: String? = ""
    @Persisted public var yearEnd: Int? = 0
    @Persisted public var yearStart: Int? = 0
    @Persisted public var imageBackground: String? = ""
}

public class PlatformRequirementModuleEntity: Object{
    @Persisted(primaryKey: true) public var id = UUID()
    @Persisted public var minimum: String? = ""
}

public class StoreDetailsModuleEntity: Object{
  @Persisted(primaryKey: true) public var id = UUID()
  @Persisted public var url: String = ""
  @Persisted public var store: StoreModuleEntity? = nil
}

public class StoreModuleEntity: Object{
  @Persisted(primaryKey: true) public var id = UUID()
  @Persisted public var name: String? = ""
  @Persisted public var slug: String? = ""
  @Persisted public var gamesCount: Int? = 0
  @Persisted public var domain: String? = ""
  @Persisted public var imageBackground: String? = ""
}

public class DeveloperInDetailsModuleEntity: Object{
  @Persisted(primaryKey: true) public var id = UUID()
  @Persisted public var name: String = ""
  @Persisted public var slug: String = ""
  @Persisted public var gamesCount: Int = 0
  @Persisted public var imageBackground: String = ""
}

public class PublisherModuleEntity: Object{
  @Persisted(primaryKey: true) public var id = UUID()
  @Persisted public var name: String = ""
  @Persisted public var slug: String = ""
  @Persisted public var gamesCount: Int = 0
  @Persisted public var imageBackground: String = ""
}

public class GenreInDetailsModuleEntity: Object{
  @Persisted(primaryKey: true) public var id = UUID()
  @Persisted public var name: String = ""
  @Persisted public var slug: String = ""
  @Persisted public var gamesCount: Int = 0
  @Persisted public var imageBackground: String = ""
}

public class TagModuleEntity: Object{
  @Persisted(primaryKey: true) public var id = UUID()
  @Persisted public var name: String = ""
  @Persisted public var slug: String = ""
  @Persisted public var gamesCount: Int = 0
  @Persisted public var imageBackground: String = ""
}

