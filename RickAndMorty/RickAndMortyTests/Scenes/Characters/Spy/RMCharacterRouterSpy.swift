//
//  RMCharacterRouterSpy.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation
@testable import RickAndMorty

final class RMCharacterRouterSpy: RMCharacterRouterProtocol {
    private(set) var navigateToDetailCalled = false
    private(set) var navigateToDetailParam: RMCharacter?

    func navigateToDetail(with character: RMCharacter) {
        navigateToDetailCalled = true
        navigateToDetailParam = character
    }
}
