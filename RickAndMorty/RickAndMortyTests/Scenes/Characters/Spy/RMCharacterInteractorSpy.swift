//
//  RMCharacterInteractorSpy.swift
//  RickAndMortyTests
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation
@testable import RickAndMorty

final class RMCharacterInteractorSpy: RMCharacterInteractorProtocol {
    
    private(set) var fetchCharactersCalled = false
    
    func fetchCharacters() {
        fetchCharactersCalled = true
    }
}
