//
//  Color+Init.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 22/11/2021.
//

import SwiftUI

extension Color {
    enum AssetColor: String {
        case darkGrey, lightGrey, green
    }
    
    init(_ assetColor: AssetColor) {
        self = Color(assetColor.rawValue.capitalized)
    }
}

