//
//  RMService.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation
import Combine

protocol RMService {
    func fetchCharacters() -> AnyPublisher<RMCharacters, APIError>
}

import Combine

extension ServiceProvider: RMService where E == RMEndpoint {

    func fetchCharacters() -> AnyPublisher<RMCharacters, APIError> {
        requestDecodable(.character) //, as: RMCharacters.self
    }

    // func fetchLocations() -> AnyPublisher<RMLocations, APIError> { requestDecodable(.location) }
    // func fetchEpisodes()  -> AnyPublisher<RMEpisodes,  APIError> { requestDecodable(.episode)  }
}
