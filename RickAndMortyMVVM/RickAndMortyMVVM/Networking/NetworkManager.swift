//
//  NetworkManager.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 5.08.2025.
//

import Foundation

actor NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    func get<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        endpoint.headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let jsonBody = String(data: data, encoding: .utf8) ?? ""
        debugPrint(jsonBody)
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
}

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}
