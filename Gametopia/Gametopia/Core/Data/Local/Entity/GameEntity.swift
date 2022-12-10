//
//  GameEntity.swift
//  Gametopia
//
//  Created by Patricia Fiona on 22/11/22.
//

import RealmSwift
import Foundation

class GameEntity: Object {
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
  @Persisted var parentPlatforms: List<PlatformEntity> = List<PlatformEntity>()
  @Persisted var platforms: List<DetailPlatformEntity> = List<DetailPlatformEntity>()
  @Persisted var stores: List<StoreDetailsEntity> = List<StoreDetailsEntity>()
  @Persisted var developers: List<DeveloperInDetailsEntity> = List<DeveloperInDetailsEntity>()
  @Persisted var genres: List<GenreInDetailsEntity> = List<GenreInDetailsEntity>()
  @Persisted var tags: List<TagEntity> = List<TagEntity>()
  @Persisted var publishers: List<PublisherEntity> = List<PublisherEntity>()
  @Persisted var descriptionRaw: String = ""
}

class PlatformEntity: Object {
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
}

class DetailPlatformEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var platform: PlatformDetailsEntity? = nil
  @Persisted var releasedAt: String = ""
  @Persisted var requirements: PlatformRequirementEntity? = nil
}

class PlatformDetailsEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
    @Persisted var name: String? = ""
    @Persisted var slug: String? = ""
    @Persisted var gamesCount: Int? = 0
    @Persisted var image: String? = ""
    @Persisted var yearEnd: Int? = 0
    @Persisted var yearStart: Int? = 0
    @Persisted var imageBackground: String? = ""
}

class PlatformRequirementEntity: Object{
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var minimum: String? = ""
}

class StoreDetailsEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var url: String = ""
  @Persisted var store: StoreEntity? = nil
}

class StoreEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var name: String? = ""
  @Persisted var slug: String? = ""
  @Persisted var gamesCount: Int? = 0
  @Persisted var domain: String? = ""
  @Persisted var imageBackground: String? = ""
}

class DeveloperInDetailsEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var gamesCount: Int = 0
  @Persisted var imageBackground: String = ""
}

class PublisherEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var gamesCount: Int = 0
  @Persisted var imageBackground: String = ""
}

class GenreInDetailsEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var gamesCount: Int = 0
  @Persisted var imageBackground: String = ""
}

class TagEntity: Object{
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var gamesCount: Int = 0
  @Persisted var imageBackground: String = ""
}
