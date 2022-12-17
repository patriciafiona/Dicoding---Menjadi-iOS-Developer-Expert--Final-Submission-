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
  public var games_count: Int?
  public var image_background: String?
  public var description: String?
}
