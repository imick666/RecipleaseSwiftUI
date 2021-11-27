//
//  FakeApiConfig.swift
//  RecipeaseSwiftUITests
//
//  Created by Mickael Ruzel on 27/11/2021.
//

import Foundation
@testable import RecipeaseSwiftUI

struct FakeApiConfig: APIConfig {
    var endpoint: String {
        "https://google.fr"
    }
    
    var credential: [String : String] { [:] }
    
    
}
