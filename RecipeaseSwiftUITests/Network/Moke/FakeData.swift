//
//  EdamamFakeData.swift
//  RecipeaseSwiftUITests
//
//  Created by Mickael Ruzel on 27/11/2021.
//

import Foundation

enum GoodOrBad {
    case good, bad
}

protocol FakeData {
    var fakeData: Data { get }
    var fakeResponse: HTTPURLResponse { get }
}
