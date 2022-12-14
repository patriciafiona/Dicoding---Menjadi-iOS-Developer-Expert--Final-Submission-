//
//  File.swift
//  
//
//  Created by Patricia Fiona on 14/12/22.
//

import Foundation

public struct GenreFilterDropdownOptionModel: Hashable {
    let key: String
    let value: String

    public static func == (lhs: GenreFilterDropdownOptionModel, rhs: GenreFilterDropdownOptionModel) -> Bool {
        return lhs.key == rhs.key
    }
}
