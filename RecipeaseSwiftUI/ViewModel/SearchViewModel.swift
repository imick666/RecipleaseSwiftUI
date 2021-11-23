//
//  SearchViewModel.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 23/11/2021.
//

import Foundation

final class SearchViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var ingredients: [String] = ["Chicken", "Potatoes", "Tomatoes"]
    @Published var ingredientTextField: String = ""
    
    // MARK: - Functions
    
    func addIngredient() {
        let separated = ingredientTextField
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: ",")
            .filter { $0 != "" }
        
        ingredients.append(contentsOf: separated)
        
        ingredientTextField = ""
    }
    
    func deleteIngredient(for index: Int) {
        ingredients.remove(at: index)
    }
    
    func clearIngredients() {
        ingredients = []
    }
    
    func searchForRecipes() {
        
    }
    
}
