//
//  APIClient.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation
import Combine

protocol URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}

import Foundation
import Combine

final class APIClient<E: APIEndpoint>: APIClientProtocol {

    private let session: URLSessionProtocol
    init(session: URLSessionProtocol = URLSession.shared) { self.session = session }

    func request(_ endpoint: E) -> AnyPublisher<Data, APIError> {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody   = endpoint.body
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard
                    let http = response as? HTTPURLResponse,
                    (200...299).contains(http.statusCode)
                else {
                    throw APIError.customError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
                }
                return data
            }
            .mapError { ($0 as? APIError) ?? .requestFailed }
            .eraseToAnyPublisher()
    }
}
