//
//  RMCharacters.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import Foundation

// MARK: - RickAndMorty
struct RMCharacters: Codable {
    let info: RMCharacterInfo?
    let results: [RMCharacter]?
}

// MARK: - Info
struct RMCharacterInfo: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
struct RMCharacter: Codable {
    let id: Int?
    let name: String?
    let status: RMStatus?
    let species: String?
    let type: String?
    let gender: String?
    let origin, location: RMLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

// MARK: - Location
struct RMLocation: Codable {
    let name: String?
    let url: String?
}

enum RMStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
