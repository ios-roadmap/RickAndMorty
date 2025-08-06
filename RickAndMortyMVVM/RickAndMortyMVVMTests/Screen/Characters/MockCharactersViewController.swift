//
//  MockCharactersViewController.swift
//  RickAndMortyMVVMTests
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import UIKit
@testable import RickAndMortyMVVM

final class MockCharactersViewController: CharactersViewControllerInterface {
    
    var prepareCollectionViewCalled = false
    var setBackgroundColorCalled = false
    var setBackgroundColorParam: UIColor? = nil
    var preFetchCalled = false
    var fetchLoadedCalled = false
    var fetchFailedCalled = false
    var fetchFailedParam: String? = nil
    
    init() {
        
    }
    
    func prepareCollectionView() {
        prepareCollectionViewCalled = true
    }
    
    func setBackgroundColor(_ color: UIColor) {
        setBackgroundColorCalled = true
        setBackgroundColorParam = color
    }
    
    func preFetch() {
        preFetchCalled = true
    }
    
    func fetchLoaded() {
        fetchLoadedCalled = true
    }
    
    func fetchFailed(message: String) {
        fetchFailedCalled = true
        fetchFailedParam = message
    }
}
