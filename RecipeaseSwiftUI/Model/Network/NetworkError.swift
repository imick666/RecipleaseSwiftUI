//
//  NetworkError.swift
//  RecipeaseSwiftUI
//
//  Created by Mickael Ruzel on 10/12/2021.
//

import Foundation

enum NetworkError: Error {
    case networkError, jsonError, imageError, other(Error)
    
    init(_ error: Error) {
        switch error {
        case is URLError: self = .networkError
        case is DecodingError: self = .jsonError
        case is NetworkError: self = error as! NetworkError
        default: self = .other(error)
        }
    }
}

extension NetworkError: Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.networkError, .networkError): return true
        case (.jsonError, .jsonError): return true
        case (.imageError, .imageError): return true
        case (.other(let lhsError), .other(let rhsError)): return lhsError.localizedDescription == rhsError.localizedDescription
        default: return false
        }
    }
    
    
}
