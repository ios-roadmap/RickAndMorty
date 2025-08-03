//
//  APIEndpoint.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation
import Combine

protocol APIEndpoint {
    var baseURL: URL { get }
    var path:     String { get }
    var method:   HTTPMethod { get }
    var headers:  [String: String]? { get }
    var body:     Data? { get }
}

extension APIEndpoint {
    var mockNamespace: String {
        String(describing: type(of: self))
    }

    var mockFileName: String {
        let cleanedPath = path
            .trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            .replacingOccurrences(of: "/", with: "_")
        return "\(mockNamespace)_\(cleanedPath)"
    }
}

enum HTTPMethod: String {
    case get  = "GET"
    case post = "POST"
}

enum APIError: Error, Equatable {
    case requestFailed
    case decodingFailed
    case customError(statusCode: Int)
}
