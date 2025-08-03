//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation

enum RMEndpoint: String, APIEndpoint {
    case character
    case location
    case episode

    var baseURL: URL { URL(string: "https://rickandmortyapi.com/api")! }

    var path: String {
        switch self {
        case .character: return "/character"
        case .location:  return "/location"
        case .episode:   return "/episode"
        }
    }

    var method: HTTPMethod { .get }
    var headers: [String: String]? { ["Content-Type": "application/json"] }
    var body: Data? { nil }
}
