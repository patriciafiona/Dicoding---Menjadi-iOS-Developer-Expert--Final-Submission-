//
//  File.swift
//  
//
//  Created by Patricia Fiona on 13/12/22.
//

import Foundation
import RealmSwift

final class DetailGameTransformer {
  
  static func mapDetailGameResponsesToEntities(
    input detailResponse: DetailGameResponse
  ) -> GameModuleEntity {
    let result = detailResponse
    let newDetailGame = GameModuleEntity()
    
    newDetailGame.id = result.id ?? 0
    newDetailGame.isFavorite = false //default for first store
    newDetailGame.name = result.name ?? "Unknown Name"
    newDetailGame.nameOriginal = result.nameOriginal ?? "Unknown Original Name"
    newDetailGame.slug = result.slug ?? "Unknown Slug"
    newDetailGame.desc = result.description ?? "No description"
    newDetailGame.released = result.released ?? "Unknown released"
    newDetailGame.updated = result.updated ?? "Unknown updated"
    newDetailGame.backgroundImage = result.backgroundImage ?? ""
    newDetailGame.backgroundImageAdditional = result.backgroundImageAdditional ?? ""
    newDetailGame.website = result.website ?? ""
    newDetailGame.rating = result.rating ?? 0.0
    newDetailGame.added = result.added ?? 0
    newDetailGame.playtime = result.playtime ?? 0
    newDetailGame.achievementsCount = result.achievementsCount ?? 0
    newDetailGame.ratingsCount = result.ratingsCount ?? 0
    newDetailGame.suggestionsCount = result.suggestionsCount ?? 0
    newDetailGame.reviewsCount = result.reviewsCount ?? 0
    newDetailGame.descriptionRaw = result.descriptionRaw ?? ""
    
    //parent platforms
    let temp = List<PlatformModuleEntity>()
    if(result.parentPlatforms != nil){
      for platform in result.parentPlatforms! {
        let platformTemp = PlatformModuleEntity()
        platformTemp.id = UUID()
        platformTemp.slug = platform.platform.slug ?? "Unknown Slug"
        platformTemp.name = platform.platform.name ?? "Unknown Name"
        
        temp.append(
          platformTemp
        )
      }
      newDetailGame.parentPlatforms = temp
    }
    
    // Platforms
    let temp01 = List<DetailPlatformModuleEntity>()
    for platform in result.platforms! {
      let platformTemp = DetailPlatformModuleEntity()
      
      //Platform detail
      let platformDetailTemp = PlatformDetailsModuleEntity()
      platformDetailTemp.id = UUID()
      platformDetailTemp.name = platform.platform?.name ?? "Unknown name"
      platformDetailTemp.slug = platform.platform?.slug ?? "Unknown slug"
      platformDetailTemp.gamesCount = platform.platform?.gamesCount ?? 0
      platformDetailTemp.image = platform.platform?.image ?? ""
      platformDetailTemp.imageBackground = platform.platform?.imageBackground ?? ""
      platformDetailTemp.yearEnd = platform.platform?.yearEnd ?? 0
      platformDetailTemp.yearStart = platform.platform?.yearStart ?? 0
      
      //Platform requirement
      let platfromRequrementTemp = PlatformRequirementModuleEntity()
      platfromRequrementTemp.minimum = platform.requirements?.minimum ?? ""
      
      //add to DetailPlatformEntity
      platformTemp.platform = platformDetailTemp
      platformTemp.releasedAt = platform.releasedAt ?? "Unknown release"
      platformTemp.requirements = platfromRequrementTemp
      
      temp01.append(
        platformTemp
      )
    }
    newDetailGame.platforms = temp01
    
    //StoreDetailsEntity
    let temp02 = List<StoreDetailsModuleEntity>()
    for store in result.stores!{
      let storeTemp = StoreDetailsModuleEntity()
      
      let storeEntity = StoreModuleEntity()
      storeEntity.id = UUID()
      storeEntity.name = store.store?.name ?? "Unknown name"
      storeEntity.slug = store.store?.slug ?? "Unknown slug"
      storeEntity.gamesCount = store.store?.gamesCount ?? 0
      storeEntity.domain = store.store?.domain ?? "Unknown domain"
      storeEntity.imageBackground = store.store?.imageBackground ?? ""
      
      storeTemp.id =  UUID()
      storeTemp.url = store.url ?? ""
      storeTemp.store = storeEntity
      
      temp02.append(storeTemp)
    }
    
    newDetailGame.stores = temp02
    
    //DeveloperInDetailsEntity
    let temp03 = List<DeveloperInDetailsModuleEntity>()
    for developer in result.developers!{
      let developerInDetailsEntity = DeveloperInDetailsModuleEntity()
      developerInDetailsEntity.id = UUID()
      developerInDetailsEntity.name = developer.name ?? "Unknown name"
      developerInDetailsEntity.slug = developer.slug ?? "Unknown slug"
      developerInDetailsEntity.gamesCount = developer.gamesCount ?? 0
      developerInDetailsEntity.imageBackground = developer.imageBackground ?? ""
      
      temp03.append(developerInDetailsEntity)
    }
    
    newDetailGame.developers = temp03
    
    //GenreInDetailsEntity
    let temp04 = List<GenreInDetailsModuleEntity>()
    for genre in result.genres!{
      let genreInDetailsEntity = GenreInDetailsModuleEntity()
      genreInDetailsEntity.id = UUID()
      genreInDetailsEntity.name = genre.name ?? "Unknown name"
      genreInDetailsEntity.slug = genre.slug ?? "Unknown slug"
      genreInDetailsEntity.gamesCount = genre.gamesCount ?? 0
      genreInDetailsEntity.imageBackground = genre.imageBackground ?? ""
      
      temp04.append(genreInDetailsEntity)
    }
    
    newDetailGame.genres = temp04
    
    //TagEntity
    let temp05 = List<TagModuleEntity>()
    for tag in result.tags! {
      let tagEntity = TagModuleEntity()
      tagEntity.id = UUID()
      tagEntity.name = tag.name ?? "Unknown name"
      tagEntity.slug = tag.slug ?? "Unknown slug"
      tagEntity.gamesCount = tag.gamesCount ?? 0
      tagEntity.imageBackground = tag.imageBackground ?? ""
      
      temp05.append(tagEntity)
    }
    
    newDetailGame.tags = temp05
    
    //PublisherEntity
    let temp06 = List<PublisherModuleEntity>()
    for publisher in result.publishers! {
      let publisherEntity = PublisherModuleEntity()
      publisherEntity.id =  UUID()
      publisherEntity.name = publisher.name ?? "Unknown name"
      publisherEntity.slug = publisher.slug ?? "Unknown slug"
      publisherEntity.gamesCount = publisher.gamesCount ?? 0
      publisherEntity.imageBackground = publisher.imageBackground ?? ""
      
      temp06.append(publisherEntity)
    }
    
    newDetailGame.publishers = temp06
    
    return newDetailGame
  }
  
  static func mapDetailGameResponsesToEntities(
    input detailResponse: [DetailGameResponse]
  ) -> [GameModuleEntity] {
    return detailResponse.map { result in
      let newDetailGame = GameModuleEntity()
      
      newDetailGame.id = result.id ?? 0
      newDetailGame.isFavorite = false //default for first store
      newDetailGame.name = result.name ?? "Unknown Name"
      newDetailGame.nameOriginal = result.nameOriginal ?? "Unknown Original Name"
      newDetailGame.slug = result.slug ?? "Unknown Slug"
      newDetailGame.desc = result.description ?? "No description"
      newDetailGame.released = result.released ?? "Unknown released"
      newDetailGame.updated = result.updated ?? "Unknown updated"
      newDetailGame.backgroundImage = result.backgroundImage ?? ""
      newDetailGame.backgroundImageAdditional = result.backgroundImageAdditional ?? ""
      newDetailGame.website = result.website ?? ""
      newDetailGame.rating = result.rating ?? 0.0
      newDetailGame.added = result.added ?? 0
      newDetailGame.playtime = result.playtime ?? 0
      newDetailGame.achievementsCount = result.achievementsCount ?? 0
      newDetailGame.ratingsCount = result.ratingsCount ?? 0
      newDetailGame.suggestionsCount = result.suggestionsCount ?? 0
      newDetailGame.reviewsCount = result.reviewsCount ?? 0
      newDetailGame.descriptionRaw = result.descriptionRaw ?? ""
      
      //parent platforms
      let temp = List<PlatformModuleEntity>()
      for platform in result.parentPlatforms! {
        let platformTemp = PlatformModuleEntity()
        platformTemp.id = UUID()
        platformTemp.slug = platform.platform.slug ?? "Unknown Slug"
        platformTemp.name = platform.platform.name ?? "Unknown Name"
        
        temp.append(
          platformTemp
        )
      }
      newDetailGame.parentPlatforms = temp
      
      // Platforms
      let temp01 = List<DetailPlatformModuleEntity>()
      for platform in result.platforms! {
        let platformTemp = DetailPlatformModuleEntity()
        
        //Platform detail
        let platformDetailTemp = PlatformDetailsModuleEntity()
        platformDetailTemp.id = UUID()
        platformDetailTemp.name = platform.platform?.name ?? "Unknown name"
        platformDetailTemp.slug = platform.platform?.slug ?? "Unknown slug"
        platformDetailTemp.gamesCount = platform.platform?.gamesCount ?? 0
        platformDetailTemp.image = platform.platform?.image ?? ""
        platformDetailTemp.imageBackground = platform.platform?.imageBackground ?? ""
        platformDetailTemp.yearEnd = platform.platform?.yearEnd ?? 0
        platformDetailTemp.yearStart = platform.platform?.yearStart ?? 0
        
        //Platform requirement
        let platfromRequrementTemp = PlatformRequirementModuleEntity()
        platfromRequrementTemp.minimum = platform.requirements?.minimum ?? ""
        
        //add to DetailPlatformEntity
        platformTemp.platform = platformDetailTemp
        platformTemp.releasedAt = platform.releasedAt ?? "Unknown release"
        platformTemp.requirements = platfromRequrementTemp
        
        temp01.append(
          platformTemp
        )
      }
      newDetailGame.platforms = temp01
      
      //StoreDetailsEntity
      let temp02 = List<StoreDetailsModuleEntity>()
      for store in result.stores!{
        let storeTemp = StoreDetailsModuleEntity()
        
        let storeEntity = StoreModuleEntity()
        storeEntity.id = UUID()
        storeEntity.name = store.store?.name ?? "Unknown name"
        storeEntity.slug = store.store?.slug ?? "Unknown slug"
        storeEntity.gamesCount = store.store?.gamesCount ?? 0
        storeEntity.domain = store.store?.domain ?? "Unknown domain"
        storeEntity.imageBackground = store.store?.imageBackground ?? ""
        
        storeTemp.id = UUID()
        storeTemp.url = store.url ?? ""
        storeTemp.store = storeEntity
        
        temp02.append(storeTemp)
      }
      
      newDetailGame.stores = temp02
      
      //DeveloperInDetailsEntity
      let temp03 = List<DeveloperInDetailsModuleEntity>()
      for developer in result.developers!{
        let developerInDetailsEntity = DeveloperInDetailsModuleEntity()
        developerInDetailsEntity.id = UUID()
        developerInDetailsEntity.name = developer.name ?? "Unknown name"
        developerInDetailsEntity.slug = developer.slug ?? "Unknown slug"
        developerInDetailsEntity.gamesCount = developer.gamesCount ?? 0
        developerInDetailsEntity.imageBackground = developer.imageBackground ?? ""
        
        temp03.append(developerInDetailsEntity)
      }
      
      newDetailGame.developers = temp03
      
      //GenreInDetailsEntity
      let temp04 = List<GenreInDetailsModuleEntity>()
      for genre in result.genres!{
        let genreInDetailsEntity = GenreInDetailsModuleEntity()
        genreInDetailsEntity.id = UUID()
        genreInDetailsEntity.name = genre.name ?? "Unknown name"
        genreInDetailsEntity.slug = genre.slug ?? "Unknown slug"
        genreInDetailsEntity.gamesCount = genre.gamesCount ?? 0
        genreInDetailsEntity.imageBackground = genre.imageBackground ?? ""
        
        temp04.append(genreInDetailsEntity)
      }
      
      newDetailGame.genres = temp04
      
      //TagEntity
      let temp05 = List<TagModuleEntity>()
      for tag in result.tags! {
        let tagEntity = TagModuleEntity()
        tagEntity.id = UUID()
        tagEntity.name = tag.name ?? "Unknown name"
        tagEntity.slug = tag.slug ?? "Unknown slug"
        tagEntity.gamesCount = tag.gamesCount ?? 0
        tagEntity.imageBackground = tag.imageBackground ?? ""
        
        temp05.append(tagEntity)
      }
      
      newDetailGame.tags = temp05
      
      //PublisherEntity
      let temp06 = List<PublisherModuleEntity>()
      for publisher in result.publishers! {
        let publisherEntity = PublisherModuleEntity()
        publisherEntity.id = UUID()
        publisherEntity.name = publisher.name ?? "Unknown name"
        publisherEntity.slug = publisher.slug ?? "Unknown slug"
        publisherEntity.gamesCount = publisher.gamesCount ?? 0
        publisherEntity.imageBackground = publisher.imageBackground ?? ""
        
        temp06.append(publisherEntity)
      }
      
      newDetailGame.publishers = temp06
      
      return newDetailGame
    }
  }
  
  static func mapDetailGameResponseToEntities(
    input gameResult: [GameResult]
  ) -> [GameModuleEntity] {
    return gameResult.map { result in
      let newDetailGame = GameModuleEntity()
      
      newDetailGame.id = result.id ?? 0
      newDetailGame.isFavorite = false //default for first store
      newDetailGame.name = result.name ?? "Unknown Name"
      newDetailGame.released = result.released ?? "Unknown released"
      newDetailGame.backgroundImage = result.backgroundImage ?? ""
      newDetailGame.rating = result.rating ?? 0.0
      newDetailGame.suggestionsCount = result.suggestionsCount ?? 0
      newDetailGame.reviewsCount = result.reviewsCount ?? 0
      newDetailGame.updated = result.updated ?? "Unknown updated"
      
      return newDetailGame
    }
  }

  static func mapDetailGameEntitiesToDomains(
    input detailGameEntities: [GameModuleEntity]
  ) -> [DetailGameDomainModel] {
    return detailGameEntities.map { result in
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
  
  static func mapDetailGameEntityToDomain(
    input result: GameModuleEntity
  ) -> DetailGameDomainModel {
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
  
  static func mapDetailGameEntitiesToDomain(
    input gameEntities: [GameModuleEntity]
  ) -> [DetailGameDomainModel] {
    var arrayRes: [DetailGameDomainModel] = [DetailGameDomainModel]()
    
    for result in gameEntities{
      let temp =  DetailGameDomainModel(
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
      
      arrayRes.append(temp)
    }
    
    return arrayRes
  }
  
  static func mapDetailGameResponsesToDomains(
    input detailGameResponses: DetailGameResponse
  ) -> DetailGameDomainModel {
    
    var listParentPlatform:[PlatformModel] = [PlatformModel]()
    if detailGameResponses.parentPlatforms != nil {
      for parentPlatform in (detailGameResponses.parentPlatforms)! {
        listParentPlatform.append(
          PlatformModel(
            id: UUID(),
            name: parentPlatform.platform.name,
            slug: parentPlatform.platform.slug
          )
        )
      }
    }
    
    var listPlatform: [DetailPlatformDomainModel] = [DetailPlatformDomainModel]()
    if detailGameResponses.platforms != nil {
      for platform in (detailGameResponses.platforms)! {
        let detail: PlatformDetailsDomainModel = PlatformDetailsDomainModel(
          id: UUID(),
          name: platform.platform?.name ?? "Unknown Name",
          slug: platform.platform?.slug ?? "Unknown Slug",
          image: platform.platform?.image ?? "",
          yearEnd: platform.platform?.yearEnd ?? 0,
          yearStart: platform.platform?.yearStart ?? 0,
          gamesCount: platform.platform?.gamesCount ?? 0,
          imageBackground: platform.platform?.imageBackground ?? ""
        )
        
        let requirement = PlatformRequirementDomainModel(
          id: UUID(),
          minimum: platform.requirements?.minimum ?? ""
        )
        
        listPlatform.append(
          DetailPlatformDomainModel(
            id: UUID(),
            platform: detail,
            releasedAt: platform.releasedAt ?? "",
            requirements: requirement
          )
        )
      }
    }
    
    var listStore: [StoreDetailsDomainModel] = [StoreDetailsDomainModel]()
    if detailGameResponses.stores != nil{
      for store in (detailGameResponses.stores)! {
        listStore.append(
          StoreDetailsDomainModel(
            id: UUID(),
            url: store.url,
            store: StoreDomainModel(
              id: UUID(),
              name: store.store?.name,
              slug: store.store?.slug,
              gamesCount: store.store?.gamesCount,
              domain: store.store?.domain,
              imageBackground: store.store?.imageBackground
            )
          )
        )
      }
    }
    
    var listDeveloper: [DeveloperInDetailGameDomainModel] = [DeveloperInDetailGameDomainModel]()
    if detailGameResponses.developers != nil {
      for developer in (detailGameResponses.developers)! {
        listDeveloper.append(
          DeveloperInDetailGameDomainModel(
            id: UUID(),
            name: developer.name,
            slug: developer.slug,
            gamesCount: developer.gamesCount,
            imageBackground: developer.imageBackground
          )
        )
      }
    }

    var listGenre: [GenreInDetailsDomainModel] = [GenreInDetailsDomainModel]()
    if detailGameResponses.genres != nil {
      for genre in (detailGameResponses.genres)! {
        listGenre.append(
          GenreInDetailsDomainModel(
            id: UUID(),
            name: genre.name,
            slug: genre.slug,
            gamesCount: genre.gamesCount,
            imageBackground: genre.imageBackground
          )
        )
      }
    }

    var listTag: [TagDomainModel] = [TagDomainModel]()
    if detailGameResponses.tags != nil{
      for tag in (detailGameResponses.tags)! {
        listTag.append(
          TagDomainModel(
            id: UUID(),
            name: tag.name,
            slug: tag.slug,
            gamesCount: tag.gamesCount,
            imageBackground: tag.imageBackground
          )
        )
      }
    }

    var listPublisher: [PublisherDomainModel] = [PublisherDomainModel]()
    if detailGameResponses.publishers != nil {
      for publisher in (detailGameResponses.publishers)! {
        listPublisher.append(
          PublisherDomainModel(
            id: UUID(),
            name: publisher.name,
            slug: publisher.slug,
            gamesCount: publisher.gamesCount,
            imageBackground: publisher.imageBackground
          )
        )
      }
    }
    
    return DetailGameDomainModel(
      id: detailGameResponses.id,
      isFavorite: false, //default
      slug: detailGameResponses.slug ?? "Unknown slug",
      name: detailGameResponses.name ?? "Unknown Name",
      nameOriginal: detailGameResponses.nameOriginal ?? "Unknown Original Name",
      description: detailGameResponses.description ?? "No description",
      released: detailGameResponses.released ?? "Unknown released",
      updated: detailGameResponses.updated ?? "Unknown last updates",
      backgroundImage: detailGameResponses.backgroundImage ?? "",
      backgroundImageAdditional: detailGameResponses.backgroundImageAdditional ?? "",
      website: detailGameResponses.website ?? "",
      rating: detailGameResponses.rating ?? 0.0,
      added: detailGameResponses.added ?? 0,
      playtime: detailGameResponses.playtime ?? 0,
      achievementsCount: detailGameResponses.achievementsCount ?? 0,
      ratingsCount: detailGameResponses.ratingsCount ?? 0,
      suggestionsCount: detailGameResponses.suggestionsCount ?? 0,
      reviewsCount: detailGameResponses.reviewsCount ?? 0,
      parentPlatforms: listParentPlatform,
      platforms: listPlatform ,
      stores: listStore,
      developers: listDeveloper,
      genres: listGenre,
      tags: listTag,
      publishers: listPublisher,
      descriptionRaw: detailGameResponses.descriptionRaw ?? ""
    )
  }
}
