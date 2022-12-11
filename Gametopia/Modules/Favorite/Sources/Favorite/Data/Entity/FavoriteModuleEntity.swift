//
//  File.swift
//  
//
//  Created by Patricia Fiona on 11/12/22.
//

import RealmSwift
import Foundation

public class FavoriteModuleEntity: Object {
  @Persisted(primaryKey: true) var id = 0
  @Persisted var isFavorite: Bool = false
  @Persisted var slug = ""
  @Persisted var name = ""
  @Persisted var nameOriginal = ""
  @Persisted var desc = ""
  @Persisted var released = ""
  @Persisted var updated: String = ""
  @Persisted var backgroundImage: String = ""
  @Persisted var backgroundImageAdditional: String = ""
  @Persisted var website: String = ""
  @Persisted var rating: Double = 0.0
  @Persisted var added: Int = 0
  @Persisted var playtime: Int = 0
  @Persisted var achievementsCount: Int = 0
  @Persisted var ratingsCount: Int = 0
  @Persisted var suggestionsCount: Int = 0
  @Persisted var reviewsCount: Int = 0
  @Persisted var parentPlatforms: List<PlatformModuleEntity> = List<PlatformModuleEntity>()
  @Persisted var platforms: List<DetailPlatformModuleEntity> = List<DetailPlatformModuleEntity>()
  @Persisted var stores: List<StoreDetailsModuleEntity> = List<StoreDetailsModuleEntity>()
  @Persisted var developers: List<DeveloperInDetailsModuleEntity> = List<DeveloperInDetailsModuleEntity>()
  @Persisted var genres: List<GenreInDetailsModuleEntity> = List<GenreInDetailsModuleEntity>()
  @Persisted var tags: List<TagModuleEntity> = List<TagModuleEntity>()
  @Persisted var publishers: List<PublisherModuleEntity> = List<PublisherModuleEntity>()
  @Persisted var descriptionRaw: String = ""
}

class PlatformModuleEntity: Object {
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
}

class DetailPlatformModuleEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var platform: PlatformDetailsModuleEntity? = nil
  @Persisted var releasedAt: String = ""
  @Persisted var requirements: PlatformRequirementModuleEntity? = nil
}

class PlatformDetailsModuleEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
    @Persisted var name: String? = ""
    @Persisted var slug: String? = ""
    @Persisted var gamesCount: Int? = 0
    @Persisted var image: String? = ""
    @Persisted var yearEnd: Int? = 0
    @Persisted var yearStart: Int? = 0
    @Persisted var imageBackground: String? = ""
}

class PlatformRequirementModuleEntity: Object{
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var minimum: String? = ""
}

class StoreDetailsModuleEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var url: String = ""
  @Persisted var store: StoreModuleEntity? = nil
}

class StoreModuleEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var name: String? = ""
  @Persisted var slug: String? = ""
  @Persisted var gamesCount: Int? = 0
  @Persisted var domain: String? = ""
  @Persisted var imageBackground: String? = ""
}

class DeveloperInDetailsModuleEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var gamesCount: Int = 0
  @Persisted var imageBackground: String = ""
}

class PublisherModuleEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var gamesCount: Int = 0
  @Persisted var imageBackground: String = ""
}

class GenreInDetailsModuleEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var gamesCount: Int = 0
  @Persisted var imageBackground: String = ""
}

class TagModuleEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var gamesCount: Int = 0
  @Persisted var imageBackground: String = ""
}
