//
//  EdamamData.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 11/12/2021.
//

import Foundation
import Combine

final class RecipeViewModel: ObservableObject, Identifiable {
    
    private(set) var id: String
    private(set) var title: String = ""
    private(set) var ingredients: [String] = []
    @Published private(set) var image: Data? = nil
    private(set) var time: String = ""
    private(set) var yield: String = ""
    private(set) var url: URL
    private(set) var source: String
    private(set) var isStored = false
    
    private lazy var network = EdamamClient()
    private var subscriptions = Set<AnyCancellable>()
    
    init(_ data: EdamamDataModel.Recipe) {
        let recipe = data.detail
        self.id = recipe.url
        self.title = recipe.label
        self.ingredients = recipe.ingredientLines
        self.time = "\(recipe.totalTime)"
        self.yield = "\(recipe.yield)"
        self.url = URL(string: recipe.url)!
        self.source = recipe.source
        
        network.fetchImages(for: recipe.image)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
            .store(in: &subscriptions)
    }
    
}

#if DEBUG
extension RecipeViewModel {
    static var preview: [RecipeViewModel] {
        let bundle = Bundle.main
        let url = bundle.url(forResource: "EdamamData", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let recipes = try! JSONDecoder().decode(EdamamDataModel.self, from: data)
        
        return recipes.recipes.map { RecipeViewModel($0)}
    }
}
#endif
