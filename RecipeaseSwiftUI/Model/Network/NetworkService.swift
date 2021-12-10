//
//  NetworkSession.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 27/11/2021.
//

import Foundation
import Combine

protocol NetworkSession {
    func request(url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

final class NetworkService: NetworkSession {
    func request(url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .eraseToAnyPublisher()
    }
}
