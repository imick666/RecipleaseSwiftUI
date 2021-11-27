//
//  FakeNetworkService.swift
//  RecipeaseSwiftUITests
//
//  Created by Mickael Ruzel on 27/11/2021.
//

import Foundation
import Combine
@testable import RecipeaseSwiftUI

final class FakeNetworkService: NetworkSession {
    
    private var fakeData: FakeData
    
    init(fakeData: FakeData) {
        self.fakeData = fakeData
    }
    
    func request(url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> {
        
        Just((fakeData.fakeData, fakeData.fakeResponse))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
    
}
