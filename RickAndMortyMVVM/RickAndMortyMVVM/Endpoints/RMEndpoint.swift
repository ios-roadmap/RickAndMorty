//
//  RMEndpoint.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import Foundation

enum RMEndpoint: APIEndpoint {
    case character(page: Int?)
    case location
    case episode

    var baseURL: URL { URL(string: "https://rickandmortyapi.com/api")! }

    var path: String {
        switch self {
        case .character(let page):
            var path: String = "/character"
            if let page {
                path += "?page=\(page)"
            }
            return path
            //https://rickandmortyapi.com/api/character?page=2"
        case .location:
            return "/location"
        case .episode:   
            return "/episode"
        }
    }

    var method: HTTPMethod { .get }
    var headers: [String: String]? { ["Content-Type": "application/json"] }
    var body: Data? { nil }
}
