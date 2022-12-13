//
//  File.swift
//  
//
//  Created by Patricia Fiona on 13/12/22.
//

import Foundation

public struct SearchDomainModel: Equatable, Identifiable{
  public var id: Int?
  public var name, slug: String?
  public var playtime: Int?
  public var released: String?
  public var rating: Double?
  public var score: String?
  public var backgroundImage: String?
}
