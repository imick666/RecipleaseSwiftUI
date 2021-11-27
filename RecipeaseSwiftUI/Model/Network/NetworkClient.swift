//
//  NetworkService.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 27/11/2021.
//

import Foundation
import Combine

final class NetworkClient {
    
    // MARK: - Properties
    
    private var apiConfig: APIConfig
    private var session: NetworkSession
    
    // MARK: - Init
    
    init(apiConfig: APIConfig,
         session: NetworkSession = NetworkService()) {
        self.apiConfig = apiConfig
        self.session = session
        
    }
    
    // MARK: - Functions
    
    func request(queryItems: [String: String]) -> AnyPublisher<EdamamDataModel, Error> {
        do {
            let url = try apiConfig.encodedURL(queries: queryItems)
            
            return session.request(url: url)
                .tryMap { output in
                    guard let response = output.response as? HTTPURLResponse else {
                        throw URLError(.cannotConnectToHost)
                    }
                    guard response.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return output.data
                }
                .decode(type: EdamamDataModel.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
            
        } catch {
            return Fail(outputType: EdamamDataModel.self, failure: error).eraseToAnyPublisher()
        }
        
        
    }
    
}
