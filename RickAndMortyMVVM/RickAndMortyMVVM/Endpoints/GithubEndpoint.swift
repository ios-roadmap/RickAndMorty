//
//  GithubEndpoint.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 6.08.2025.
//

import Foundation

enum GithubEndpoint: Endpoint {
    case user(String)
    
    var baseURL: String {
        "https://api.github.com/users"
    }
    
    var path: String {
        switch self {
        case .user(let username):
            return "/\(username)"
        }
    }
}
