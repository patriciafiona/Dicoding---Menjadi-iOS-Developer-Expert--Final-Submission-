//
//  File.swift
//  
//
//  Created by Patricia Fiona on 13/12/22.
//

import Foundation
import Core

public struct SearchTransformer: Mapper {
  public typealias Entity = [SearchModuleEntity]
  public typealias Response = [SearchResult]
  public typealias Domain = [SearchDomainModel]
  
  public init() {}
  
  public func transformResponseToDomain(response: [SearchResult]) -> [SearchDomainModel] {
    return response.map { result in
      return SearchDomainModel(
        id: result.id ?? 0,
        name: result.name ?? "Unknown Name",
        slug: result.slug ?? "Unknown Slug",
        playtime: result.playtime ?? 0,
        released: result.released ?? "Unknown released",
        rating: result.rating ?? 0.0,
        score: result.score ?? "Unknown score",
        backgroundImage: result.backgroundImage ?? ""
      )
    }
  }
  
  public func transformResponseToEntity(response: [SearchResult]) -> [SearchModuleEntity] {
    return []
  }
  
  public func transformEntityToDomain(entity: [SearchModuleEntity]) -> [SearchDomainModel] {
    return []
  }
}

