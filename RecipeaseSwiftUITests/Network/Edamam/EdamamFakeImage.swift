//
//  EdamamFakeImage.swift
//  RecipeaseSwiftUITests
//
//  Created by Mickael Ruzel on 10/12/2021.
//

import Foundation

final class EdamamFakeImage: FakeData {
    var fakeData: Data
    
    var fakeResponse: HTTPURLResponse
    
    init(data: GoodOrBad, response: GoodOrBad) {
        self.fakeData = {
            switch data {
            case .good:
                let bundle = Bundle(for: EdamamFakeJson.self)
                let url = bundle.url(forResource: "Image", withExtension: "jpg")!
                return try! Data(contentsOf: url)
            case .bad: return "BadData".data(using: .utf8)!
            }
        }()
                
        self.fakeResponse = {
            switch response {
            case .good: return HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            case .bad: return HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            }
        }()
    }
    
    
}
