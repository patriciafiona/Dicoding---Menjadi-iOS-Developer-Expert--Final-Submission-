//
//  File.swift
//  
//
//  Created by Patricia Fiona on 16/12/22.
//

import Foundation

public struct GenreFilterDropdownOptionDomainModel: Hashable {
    public let key: String
    public let value: String

    public static func == (lhs: GenreFilterDropdownOptionDomainModel, rhs: GenreFilterDropdownOptionDomainModel) -> Bool {
        return lhs.key == rhs.key
    }
}
