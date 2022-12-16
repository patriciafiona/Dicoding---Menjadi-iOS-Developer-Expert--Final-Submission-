//
//  File.swift
//  
//
//  Created by Patricia Fiona on 15/12/22.
//

import Foundation

// MARK: - Welcome
public struct DeveloperResponse: Decodable {
    public let count: Int?
    public let next, previous: String?
    public let results: [DeveloperResult]?
}

// MARK: - Result
public struct DeveloperResult: Decodable {
    public let id: Int?
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
    public let games: [GameInDeveloper]?
}

public struct GameInDeveloper: Decodable {
    public let id: Int?
    public let name, slug: String?
    public let added: Int?
}
