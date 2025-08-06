//
//  MockCharactersViewController.swift
//  RickAndMortyMVVMTests
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import UIKit
@testable import RickAndMortyMVVM

final class MockCharactersViewController: CharactersViewControllerInterface,
                                          AlertShowable {
    
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
        showAlert(message, completion: nil)
    }
    
    var showAlertCalled = false
    var onShowAlert: (() -> Void)?
    func showAlert(_ message: String, completion: RickAndMortyMVVM.VoidHandler?) {
        showAlertCalled = true
        onShowAlert?()
    }
    
    func showAndDismissAlert(_ message: String, completion: RickAndMortyMVVM.VoidHandler?) {
        
    }
    
    func showConfirmationAlert(_ message: String, completion: RickAndMortyMVVM.VoidHandler?) {
        
    }
}
