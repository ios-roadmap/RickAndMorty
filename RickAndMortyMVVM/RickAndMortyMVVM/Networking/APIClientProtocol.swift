//
//  APIClientProtocol.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import Foundation

protocol APIClientInterface {
    associatedtype EndpointType: APIEndpoint
    
    func request<T: Decodable>(_ endpoint: EndpointType) async throws -> T
}

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

enum HTTPMethod: String {
    case get  = "GET"
    case post = "POST"
}

enum APIError: Error {
    case requestFailed
    case decodingFailed
    case invalidResponse
    case customError(statusCode: Int)
}

final class APIClient<E: APIEndpoint>: APIClientInterface {
    
    func request<T: Decodable>(_ endpoint: E) async throws -> T {
        let url = URL(string: "\(endpoint.baseURL)\(endpoint.path)")!
        print("----------------------------------------------------")
        print("URL: \(url)")
        print("----------------------------------------------------")
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.customError(statusCode: httpResponse.statusCode)
            }

            do {
                let body = String(data: data, encoding: .utf8)
                print("----------------------------------------------------")
                print(body ?? "")
                print("----------------------------------------------------")
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw APIError.decodingFailed
            }

        } catch {
            throw APIError.requestFailed
        }
    }
}
