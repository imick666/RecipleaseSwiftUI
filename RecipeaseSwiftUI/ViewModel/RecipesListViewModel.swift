//
//  RecipesListViewModel.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 27/11/2021.
//

import Foundation
import Combine

final class RecipeListViewModel: ObservableObject {
    
    @Published var recipes: [RecipeCellViewModel] = []
    @Published var isLoading = true
    
    private lazy var networkClient = EdamamClient()
    private var subscriptions = Set<AnyCancellable>()
    
    init(ingredients: [String]) {
        networkClient.fetchRecipes(for: ingredients)
            .receive(on: DispatchQueue.main)
            .map { $0.recipes.map { RecipeCellViewModel(recipe: $0.detail) } }
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
        self.recipes = EdamamDataModel.sampleData.recipes.map { RecipeCellViewModel(recipe: $0.detail) }
    }
    #endif
}


