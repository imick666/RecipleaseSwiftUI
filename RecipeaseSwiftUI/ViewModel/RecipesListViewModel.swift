//
//  RecipesListViewModel.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 27/11/2021.
//

import Foundation
import Combine

final class RecipeListViewModel: ObservableObject {
    
    @Published var recipes: [RecipeViewModel] = []
    @Published var isLoading = true
    
    private lazy var networkClient = EdamamClient()
    private var subscriptions = Set<AnyCancellable>()
    
    init(ingredients: [String]) {
        networkClient.fetchRecipes(for: ingredients)
            .receive(on: DispatchQueue.main)
            .map { $0.recipes.map { RecipeViewModel($0) } }
            .sink { completion in
                switch completion {
                case .finished: self.isLoading = false
                case .failure(let error): print(error)
                }
            } receiveValue: { recipes in
                self.recipes = recipes
            }
            .store(in: &subscriptions)
    }
    
    #if DEBUG
    init() {
        self.recipes = RecipeViewModel.preview
    }
    #endif
}


