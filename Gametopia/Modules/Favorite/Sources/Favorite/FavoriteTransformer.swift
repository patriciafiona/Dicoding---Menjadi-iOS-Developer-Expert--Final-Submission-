//
//  File.swift
//  
//
//  Created by Patricia Fiona on 11/12/22.
//

import Core
import Game

public struct FavoriteTransformer: Mapper {
  public typealias Response = Bool
  public typealias Entity = [GameModuleEntity]
  public typealias Domain = [DetailGameDomainModel]
  
  public init() {}
  
  public func transformResponseToDomain(response: Bool) -> [DetailGameDomainModel] {
    return []
  }
  
  public func transformResponseToEntity(response: Bool) -> [GameModuleEntity] {
    return []
  }
  
  public func transformEntityToDomain(entity: [GameModuleEntity]) -> [DetailGameDomainModel] {
    return entity.map { result in
      return DetailGameDomainModel(
        id: Int(result.id),
        isFavorite: result.isFavorite,
        slug: result.slug,
        name: result.name,
        nameOriginal: result.nameOriginal,
        description: result.desc,
        released: result.released,
        updated: result.updated,
        backgroundImage: result.backgroundImage,
        backgroundImageAdditional: result.backgroundImageAdditional,
        website: result.website,
        rating: result.rating,
        added: result.added,
        playtime: result.playtime,
        achievementsCount: result.ratingsCount,
        ratingsCount: result.reviewsCount,
        suggestionsCount: result.suggestionsCount,
        reviewsCount: result.achievementsCount,
        parentPlatforms: result.parentPlatforms.map { platform in
          return PlatformModel(
            id: platform.id,
            name: platform.name,
            slug: platform.slug
          )
        },
        platforms: result.platforms.map { data in
          return DetailPlatformDomainModel(
            id: data.id,
            platform: PlatformDetailsDomainModel(
              id: data.platform!.id,
              name: data.platform?.name,
              slug: data.platform?.slug,
              image: data.platform?.image,
              yearEnd: data.platform?.yearEnd,
              yearStart: data.platform?.yearStart,
              gamesCount: data.platform?.gamesCount,
              imageBackground: data.platform?.imageBackground
            ),
            releasedAt: data.releasedAt,
            requirements: PlatformRequirementDomainModel(
              id: data.requirements!.id,
              minimum: data.requirements?.minimum
            )
          )
        },
        stores: result.stores.map { store in
           return StoreDetailsDomainModel(
            id: store.id,
            url: store.url,
            store: StoreDomainModel(
              id: store.store!.id,
              name: store.store?.name,
              slug: store.store?.slug,
              gamesCount: store.store?.gamesCount,
              domain: store.store?.domain,
              imageBackground: store.store?.imageBackground
            )
           )
        },
        developers: result.developers.map { developer in
          return DeveloperInDetailGameDomainModel(
            id: developer.id,
            name: developer.name,
            slug: developer.slug,
            gamesCount: developer.gamesCount,
            imageBackground: developer.imageBackground
          )
        },
        genres: result.genres.map { genre in
          return GenreInDetailsDomainModel(
            id: genre.id,
            name: genre.name,
            slug: genre.slug,
            gamesCount: genre.gamesCount,
            imageBackground: genre.imageBackground
          )
        },
        tags: result.tags.map { tag in
          return TagDomainModel(
            id: tag.id,
            name: tag.name,
            slug: tag.slug,
            gamesCount: tag.gamesCount,
            imageBackground: tag.imageBackground
          )
        },
        publishers: result.publishers.map { publisher in
          return PublisherDomainModel(
            id: publisher.id,
            name: publisher.name,
            slug: publisher.slug,
            gamesCount: publisher.gamesCount,
            imageBackground: publisher.imageBackground
          )
        },
        descriptionRaw: result.descriptionRaw
      )
    }
  }
}
