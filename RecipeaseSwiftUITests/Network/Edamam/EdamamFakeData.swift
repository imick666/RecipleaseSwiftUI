//
//  EdamamFakeData.swift
//  RecipeaseSwiftUITests
//
//  Created by Mickael Ruzel on 27/11/2021.
//

import Foundation

class EdamamFakeData: FakeData {
    var fakeData: Data
    
    var fakeResponse: HTTPURLResponse

    init(data: GoodOrBad, response: GoodOrBad) {
        self.fakeData = {
            switch data {
            case .good:
                let bundle = Bundle(for: EdamamFakeData.self)
                let url = bundle.url(forResource: "EdamamData", withExtension: "json")!
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
