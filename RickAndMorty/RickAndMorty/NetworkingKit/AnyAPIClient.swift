//
//  AnyAPIClient.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation
import Combine

final class AnyAPIClient<E: APIEndpoint>: APIClientProtocol {

    private let _request: (E) -> AnyPublisher<Data, APIError>

    init<C: APIClientProtocol>(_ client: C) where C.EndpointType == E {
        _request = { endpoint in client.request(endpoint) }
    }

    func request(_ endpoint: E) -> AnyPublisher<Data, APIError> {
        _request(endpoint)
    }
}

extension AnyAPIClient {
    static func make(
        kind: APIKind,
        session: URLSessionProtocol = URLSession.shared
    ) -> AnyAPIClient<E> {
        switch kind {
        case .live: return AnyAPIClient(APIClient<E>(session: session))
        case .mock: return AnyAPIClient(MockAPIClient<E>())
        }
    }
}
