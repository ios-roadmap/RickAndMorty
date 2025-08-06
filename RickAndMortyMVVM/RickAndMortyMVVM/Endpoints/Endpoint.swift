//
//  Endpoint.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 6.08.2025.
//

import UIKit

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
}

extension Endpoint {
    var url: URL? {
        let string = "\(baseURL)\(path)"
        return URL(string: string)
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String: String]? {
        [
            "Content-Type": "application/json"
        ]
    }
    
    var body: Data? {
       nil
    }
}

enum HTTPMethod: String {
    case get  = "GET"
    case post = "POST"
}
