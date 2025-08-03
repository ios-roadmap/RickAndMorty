//
//  MockAPIClient.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation
import Combine

final class MockAPIClient<E: APIEndpoint>: APIClientProtocol {

    func request(_ endpoint: E) -> AnyPublisher<Data, APIError> {
        let fileName = endpoint.mockFileName

        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Mock file not found: \(fileName).json — Check if the file exists in the test bundle.")
            return Fail(error: .decodingFailed).eraseToAnyPublisher()
        }

        guard let data = try? Data(contentsOf: url) else {
            print("Failed to load mock data from: \(fileName).json — Ensure the file is readable and valid.")
            return Fail(error: .decodingFailed).eraseToAnyPublisher()
        }

        return Just(data)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
