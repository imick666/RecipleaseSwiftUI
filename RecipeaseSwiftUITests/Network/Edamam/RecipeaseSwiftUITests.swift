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

    var edamamClient: EdamamClient?
    
    override func tearDown() {
        super.tearDown()
        edamamClient = nil
    }
    
    // MARK: - Test
    
    func testBadResponse() {
        
        let service = FakeNetworkService(fakeData: EdamamFakeJson(data: .bad, response: .bad))
        edamamClient = EdamamClient(networkService: service)
        
        let expectation = expectation(description: "Wait for response")
        
        _ = edamamClient?.fetchRecipes(for: [])
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { XCTFail("No Error"); return }
                XCTAssertEqual(error, .networkError)
                expectation.fulfill()
            }, receiveValue: { _ in })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testBadData() {
        
        let service = FakeNetworkService(fakeData: EdamamFakeJson(data: .bad, response: .good))
        edamamClient = EdamamClient(networkService: service)
        
        let expectation = expectation(description: "Wait for response")
        
        _ = edamamClient?.fetchRecipes(for: [])
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else { XCTFail("No Error"); return }
                XCTAssertEqual(error, .jsonError)
                expectation.fulfill()
            }, receiveValue: { _ in })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGoodData() {
        
        let service = FakeNetworkService(fakeData: EdamamFakeJson(data: .good, response: .good))
        edamamClient = EdamamClient(networkService: service)
        
        let expectation = expectation(description: "Wait for response")
        
        _ = edamamClient?.fetchRecipes(for: [])
            .sink(receiveCompletion: { completion in
                guard case .finished = completion else { XCTFail("Oups an error occured ..."); return }
                expectation.fulfill()
            }, receiveValue: { recipe in
                XCTAssertEqual(recipe.recipes[1].detail.url, "http://norecipes.com/recipe/chicken-paprikash/")
            })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testFetchImageBadData() {
        let service = FakeNetworkService(fakeData: EdamamFakeImage(data: .bad, response: .good))
        edamamClient = EdamamClient(networkService: service)
        
        let expectation = expectation(description: "Wait for response")
        
        _ = edamamClient?.fetchImages(for: "BadUrlMotherFucker")
            .sink(receiveCompletion: { completion in
                guard case .finished = completion else { XCTFail("WHAT...."); return }
                expectation.fulfill()
            }, receiveValue: { XCTAssertEqual($0, nil) })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testFetchImageGoodData() {
        let service = FakeNetworkService(fakeData: EdamamFakeImage(data: .good, response: .good))
        edamamClient = EdamamClient(networkService: service)
        
        let expectation = expectation(description: "Wait for response")
        
        _ = edamamClient?.fetchImages(for: "BadUrlMotherFucker")
            .sink(receiveCompletion: { completion in
                guard case .finished = completion else { XCTFail("Oupss there's an error..."); return }
                expectation.fulfill()
            }, receiveValue: { data in
                let bundle = Bundle(for: EdamamFakeImage.self)
                let url = bundle.url(forResource: "Image", withExtension: "jpg")!
                let image = try! Data(contentsOf: url)
                
                XCTAssertEqual(data, image)
            })
        
        wait(for: [expectation], timeout: 0.01)
    }
}
