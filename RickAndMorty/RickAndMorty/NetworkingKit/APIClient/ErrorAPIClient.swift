//
//  ErrorAPIClient.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation
import Combine

final class ErrorAPIClient<E: APIEndpoint>: APIClientProtocol {

    private let error: APIError

    init(error: APIError) {
        self.error = error
    }

    func request(_ endpoint: E) -> AnyPublisher<Data, APIError> {
        Fail(error: error).eraseToAnyPublisher()
    }
}
