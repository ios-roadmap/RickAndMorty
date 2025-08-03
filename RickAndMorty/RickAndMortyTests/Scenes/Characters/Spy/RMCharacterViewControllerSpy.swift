//
//  RMCharacterViewControllerSpy.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation
@testable import RickAndMorty

final class RMCharacterViewControllerSpy: RMCharacterViewControllerProtocol {
    
    private(set) var showLoadingCalled = false
    private(set) var hideLoadingCalled = false
    private(set) var reloadDataCalled = false
    private(set) var showErrorCalled = false
    private(set) var showErrorParam: String?
    
    func showLoading() {
        showLoadingCalled = true
    }
    
    func hideLoading() {
        hideLoadingCalled = true
    }
    
    func reloadData() {
        reloadDataCalled = true
    }
    
    func showError(_ message: String) {
        showErrorCalled = true
        showErrorParam = message
    }
}
