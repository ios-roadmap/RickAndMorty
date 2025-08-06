//
//  RMServiceInterface.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 6.08.2025.
//

import Foundation

@MainActor
protocol RMServiceInterface {
    func fetchCharacters(page: Int?, completion: @escaping (Result<RMCharacters, Error>) -> Void) async
}

final class LiveRMService: RMServiceInterface {
    
    func fetchCharacters(page: Int? = 1, completion: @escaping (Result<RMCharacters, Error>) -> Void) async {
        do {
            let endpoint: Endpoint = RMEndpoint.character(page: page)
            let characters: RMCharacters = try await NetworkManager.shared.get(endpoint: endpoint)
            completion(.success(characters))
        } catch {
            completion(.failure(error))
        }
    }
}

final class MockRMService: RMServiceInterface {
    
    func fetchCharacters(page: Int? = 1, completion: @escaping (Result<RMCharacters, any Error>) -> Void) async {
        let characters: RMCharacters = .init(info: .init(count: 3, pages: 3, next: "next", prev: "prev"), results: nil)
        completion(.success(characters))
    }
}

final class ErrorRMService: RMServiceInterface {
    
    func fetchCharacters(page: Int? = 1, completion: @escaping (Result<RMCharacters, any Error>) -> Void) async {
        completion(.failure(NetworkError.invalidUrl))
    }
}
