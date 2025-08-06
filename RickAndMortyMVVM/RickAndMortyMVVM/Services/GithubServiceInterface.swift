//
//  GithubServiceInterface.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 6.08.2025.
//

import UIKit

@MainActor
protocol GithubServiceInterface {
    func getUser(userName: String, completion: @escaping (Result<GithubUser, Error>) -> Void) async
}

final class LiveGithubService: GithubServiceInterface {
    func getUser(userName: String, completion: @escaping (Result<GithubUser, Error>) -> Void) async {
        do {
            let endpoint: Endpoint = GithubEndpoint.user(userName)
            let user: GithubUser = try await NetworkManager.shared.get(endpoint: endpoint)
            completion(.success(user))
        } catch {
            completion(.failure(error))
        }
    }
}

final class MockGithubService: GithubServiceInterface {
    func getUser(
        userName: String,
        completion: @escaping (Result<GithubUser, Error>) -> Void
    ) async {
        let user: GithubUser = .init(login: "mockUser", avatarUrl: "mockUrl", bio: "mockBio")
        completion(.success(user))
    }
}

final class ErrorGithubService: GithubServiceInterface {
    func getUser(
        userName: String,
        completion: @escaping (Result<GithubUser, Error>) -> Void
    ) async {
        completion(.failure(NetworkError.invalidData))
    }
}
