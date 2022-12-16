//
//  File.swift
//  
//
//  Created by Patricia Fiona on 16/12/22.
//

import Foundation

public struct DeveloperDomainModel: Equatable, Identifiable {
    public let id: Int?
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
    public let games: [GameInDeveloperDomainModel]
}

public struct GameInDeveloperDomainModel: Equatable, Identifiable {
    public let id: Int?
    public let name, slug: String?
    public let added: Int?
}
