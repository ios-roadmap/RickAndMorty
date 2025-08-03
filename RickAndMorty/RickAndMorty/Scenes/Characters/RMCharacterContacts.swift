//
//  RMCharacterContacts.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import UIKit

// MARK: - View

protocol RMCharacterViewControllerProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func reloadData()
    func showError(_ message: String)
}

// MARK: - Presenter

protocol RMCharacterPresenterProtocol: AnyObject {
    func viewDidLoad()
    func getNumberOfItems() -> Int
    func createRMCharacterTableViewCellViewModel(at index: Int) -> RMCharacterTableViewCellViewModel
    func didSelectItem(at index: Int)
}

// MARK: - Interactor

protocol RMCharacterInteractorProtocol: AnyObject {
    func fetchCharacters()
}

protocol RMCharacterInteractorOutputProtocol: AnyObject {
    func didFetchCharacters(_ characters: RMCharacters)
    func didFailWithError(_ error: APIError)
}

// MARK: - Router

protocol RMCharacterRouterProtocol: AnyObject {
    func navigateToDetail(with character: RMCharacter)
}
