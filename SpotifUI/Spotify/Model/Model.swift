//
//  Model.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import Foundation

enum Category: String, CaseIterable {
    case all, music, podcasts
}

struct ComplexCategory {
    var name: String
    var isSelected: Bool
    var expandOnSelection: Bool
    var expandedCategory: String? = nil
    var isExpandedCategorySelected: Bool = false
}

enum CategoryType: String, CaseIterable {
    case all
    case music
    case podcasts
    
    var category: ComplexCategory {
        switch self {
        case .all:
            return ComplexCategory(name: "All", isSelected: false, expandOnSelection: false)
        case .music:
            return ComplexCategory(name: "Music", isSelected: false, expandOnSelection: false)
        case .podcasts:
            return ComplexCategory(name: "Podcasts", isSelected: false, expandOnSelection: true, expandedCategory: "Followed")
        }
    }
}
