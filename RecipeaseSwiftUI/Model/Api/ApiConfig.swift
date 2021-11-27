//
//  APIConfig.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 26/11/2021.
//

import Foundation

protocol APIConfig {
    var endpoint: String { get }
    var credential: [String: String] { get }
}

extension APIConfig {
    
    func encodedURL(queries: [String: String]) throws -> URL {
        guard var components = URLComponents(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        credential.forEach { components.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value)) }
        queries.forEach { components.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value)) }
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        return url
    }
    
}
