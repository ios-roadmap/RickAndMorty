//
//  RMCharacterInteractorOutputSpy.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation
@testable import RickAndMorty

final class RMCharacterInteractorOutputSpy: RMCharacterInteractorOutputProtocol {
    
    private(set) var didFetchCharactersCalled = false
    private(set) var didFetchCharactersParam: RMCharacters?
    
    private(set) var didFailWithErrorCalled = false
    private(set) var didFailWithErrorParam: APIError?
    
    func didFetchCharacters(_ characters: RMCharacters) {
        didFetchCharactersCalled = true
        didFetchCharactersParam = characters
    }
    
    func didFailWithError(_ error: APIError) {
        didFailWithErrorCalled = true
        didFailWithErrorParam = error
    }
}
