//
//  EdamamClient.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 10/12/2021.
//

import Foundation
import Combine
import UIKit

final class EdamamClient {
    
    // MARK: - Propeties
    
    private var networkClient: NetworkClient
    private var apiConfig: APIConfig
    
    // MARK: - Init
    
    init(networkService: NetworkSession = NetworkService()) {
        self.networkClient = NetworkClient(session: networkService)
        self.apiConfig = EdamamConfig()
    }
    
    
    // MARK: - Methodes
    
    func fetchRecipes(for ingredients: [String]) -> AnyPublisher<EdamamDataModel, NetworkError> {
        do {
            let queryItems = ["q": ingredients.joined(separator: ",")]
            let url = try apiConfig.encodedURL(queries: queryItems)
            
            return networkClient.request(for: url)
                .decode(type: EdamamDataModel.self, decoder: JSONDecoder())
                .mapError { NetworkError($0) }
                .eraseToAnyPublisher()
            
        } catch {
            return Fail(outputType: EdamamDataModel.self, failure: NetworkError(error)).eraseToAnyPublisher()
        }
    }
    
    func fetchImages(for url: String) -> AnyPublisher<Data?, Never> {
        guard let url = URL(string: url) else {
            return Just(nil).eraseToAnyPublisher()
        }
        
        return networkClient.request(for: url)
            .map {
                (UIImage(data: $0) != nil) ? $0 : nil
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
    
}
