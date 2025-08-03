//
//  ServiceProvider.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation
import Combine

struct ServiceProvider<E: APIEndpoint>: APIClientProtocol {

    private let client: AnyAPIClient<E>

    init(
        kind: APIKind,
        session: URLSessionProtocol = URLSession.shared
    ) {
        self.client = AnyAPIClient<E>.make(kind: kind, session: session)
    }

    func request(_ endpoint: E) -> AnyPublisher<Data, APIError> {
        client.request(endpoint)
    }

    func requestDecodable<T: Decodable>(
        _ endpoint: E,
        as type: T.Type = T.self
    ) -> AnyPublisher<T, APIError> {
        request(endpoint)
            .decode(type: type, decoder: JSONDecoder())
            .mapError { ($0 as? APIError) ?? .decodingFailed }
            .eraseToAnyPublisher()
    }
}
