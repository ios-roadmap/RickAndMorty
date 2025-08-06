//
//  RMEndpoint.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import Foundation

enum RMEndpoint: Endpoint {
    case character(page: Int?)
    case location
    case episode

    var baseURL: String {
        "https://rickandmortyapi.com/api"
    }

    var path: String {
        switch self {
        case .character(let page):
            var path: String = "/character"
            if let page {
                path += "?page=\(page)"
            }
            return path
        case .location:
            return "/location"
        case .episode:   
            return "/episode"
        }
    }
}
