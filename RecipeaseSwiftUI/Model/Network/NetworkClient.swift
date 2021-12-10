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
    
    private var session: NetworkSession
    
    // MARK: - Init
    
    init(session: NetworkSession = NetworkService()) {
        self.session = session
        
    }
    
    // MARK: - Functions
    
    func request(for url: URL) -> AnyPublisher<Data, NetworkError> {
        return session.request(url: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                          throw NetworkError.networkError
                      }
                return output.data
            }
            .mapError { NetworkError($0) }
            .eraseToAnyPublisher()
    }
    
}
