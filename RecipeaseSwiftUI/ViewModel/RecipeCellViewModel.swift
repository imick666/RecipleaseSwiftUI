//
//  RecipeCellViewModel.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 27/11/2021.
//

import Foundation
import Combine

final class RecipeCellViewModel: ObservableObject, Identifiable {
    
    // MARK: - Properties
    
    @Published private(set) var name: String = ""
    @Published private(set) var yield: String = ""
    @Published private(set) var time: String = ""
    @Published private(set) var image: Data?
    private(set) var id = UUID()
    
    private var subscriptions = Set<AnyCancellable>()
    private lazy var client = EdamamClient()
    
    // MARK: - Init
    
    init(recipe: EdamamDataModel.Recipe.Detail) {
        self.name = recipe.label
        self.yield = "\(recipe.yield)"
        self.time = "\(recipe.totalTime)"
            
        client.fetchImages(for: recipe.image)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error): print(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { image in
                self.image = image
            }
            .store(in: &subscriptions)
    }
    
        // MARK: - Functions
}

#if DEBUG
extension RecipeCellViewModel {
    convenience init() {
        self.init(recipe: EdamamDataModel.sampleData.recipes[0].detail)
    }
}
#endif
