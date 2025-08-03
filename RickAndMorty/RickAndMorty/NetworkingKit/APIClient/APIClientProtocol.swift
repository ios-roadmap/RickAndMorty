//
//  APIClientProtocol.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation
import Combine

protocol APIClientProtocol {
    associatedtype EndpointType: APIEndpoint
    func request(_ endpoint: EndpointType) -> AnyPublisher<Data, APIError>
}
