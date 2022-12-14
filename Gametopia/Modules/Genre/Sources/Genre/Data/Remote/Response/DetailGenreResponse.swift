//
//  File.swift
//  
//
//  Created by Patricia Fiona on 14/12/22.
//

import Foundation

public class DetailGenreResponse: Decodable {
  public var id: Int?
  public var name, slug: String?
  public var gamesCount: Int?
  public var imageBackground: String?
  public var description: String?
}
