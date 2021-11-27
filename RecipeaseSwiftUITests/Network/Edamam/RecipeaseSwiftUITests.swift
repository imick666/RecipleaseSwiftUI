//
//  RecipeaseSwiftUITests.swift
//  RecipeaseSwiftUITests
//
//  Created by Mickael Ruzel on 15/11/2021.
//

import XCTest
import Combine
@testable import RecipeaseSwiftUI

class RecipeaseSwiftUITests: XCTestCase {

    var client: NetworkClient?
    
    override func tearDown() {
        super.tearDown()
        client = nil
    }
    
    // MARK: - Tests
    
    func testBadResponse() {
        let fakeData = EdamamFakeData(data: .bad, response: .bad)
        let session = FakeNetworkService(fakeData: fakeData)
        client = NetworkClient(apiConfig: FakeApiConfig(), session: session)
        
        let expectation = expectation(description: "Wait for response")
        
        _ = client?.request(queryItems: [:])
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else {
                    XCTFail("No Error")
                    expectation.fulfill()
                    return
                }
                
                XCTAssertEqual((error as! URLError).code, .badServerResponse)
                expectation.fulfill()
            }, receiveValue: { _ in } )
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testBadData() {
        let fakeData = EdamamFakeData(data: .bad, response: .good)
        let session = FakeNetworkService(fakeData: fakeData)
        client = NetworkClient(apiConfig: FakeApiConfig(), session: session)
        
        let expectation = expectation(description: "Wait for response")
        
        _ = client?.request(queryItems: [:])
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else {
                    XCTFail("No Error")
                    expectation.fulfill()
                    return
                }
                
                XCTAssert(error is DecodingError)
                expectation.fulfill()
            }, receiveValue: { _ in } )
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGoodData() {
        let fakeData = EdamamFakeData(data: .good, response: .good)
        let session = FakeNetworkService(fakeData: fakeData)
        client = NetworkClient(apiConfig: FakeApiConfig(), session: session)
        
        let expectation = expectation(description: "Wait for response")
        
        _ = client?.request(queryItems: [:])
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error): XCTFail(error.localizedDescription); expectation.fulfill()
                case .finished: expectation.fulfill()
                }
            }, receiveValue: { data in
                XCTAssertEqual(data.hits[0].recipe.url, "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html")
            } )
        
        wait(for: [expectation], timeout: 0.01)
    }
    
}
