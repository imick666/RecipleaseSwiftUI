//
//  SearchViewModel.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 23/11/2021.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var ingredients: [String] = []
    @Published var ingredientTextField: String = ""
    @Published var showResult = false
    
    init() {
        
        #if DEBUG
        self.ingredients = ["Chicken", "Potatoes", "Tomatoes"]
        #endif
    }
    
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
    
}
