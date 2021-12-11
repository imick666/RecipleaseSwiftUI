//
//  EdamanDataModel.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 27/11/2021.
//

import Foundation

struct EdamamDataModel: Codable {
    let recipes: [Recipe]
    
    enum CodingKeys: String, CodingKey {
        case recipes = "hits"
    }
    
    // MARK: - Hit
    struct Recipe: Codable {
        let detail: Detail
        
        enum CodingKeys: String, CodingKey {
            case detail = "recipe"
        }
        
        // MARK: - Recipe
        struct Detail: Codable {
            let label: String
            let image: String
            let source: String
            let url: String
            let shareAs: String
            let yield: Int
            let healthLabels: [String]
            let ingredientLines: [String]
            let ingredients: [Ingredient]
            let calories, totalWeight: Double
            let totalTime: Int
            
            // MARK: - Ingredient
            struct Ingredient: Codable {
                let text: String
                let quantity: Double
                let measure: String?
                let food: String
                let weight: Double
                let foodCategory: String?
                let foodID: String
                let image: String?
                
                enum CodingKeys: String, CodingKey {
                    case text, quantity, measure, food, weight, foodCategory
                    case foodID = "foodId"
                    case image
                }
            }
        }
    }
}

#if DEBUG
extension EdamamDataModel {
    static var sampleData: EdamamDataModel {
        let bundle = Bundle.main
        let url = bundle.url(forResource: "EdamamData", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(EdamamDataModel.self, from: data)
    }
}
#endif




