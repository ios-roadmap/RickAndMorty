//
//  RMCharacterPresenter.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation

final class RMCharacterPresenter: RMCharacterPresenterProtocol {
    
    weak var viewController: RMCharacterViewControllerProtocol!
    var interactor: RMCharacterInteractorProtocol!
    var router: RMCharacterRouterProtocol!
    
    private var characters: [RMCharacter] = []
    
    func viewDidLoad() {
        viewController?.showLoading()
        interactor?.fetchCharacters()
    }
}

extension RMCharacterPresenter: RMCharacterInteractorOutputProtocol {
    func didFetchCharacters(_ characters: RMCharacters) {
        viewController?.hideLoading()
        self.characters = characters.results ?? []
        viewController?.reloadData()
    }
    
    func didFailWithError(_ error: APIError) {
        viewController?.hideLoading()
        viewController?.showError(error.localizedDescription)
    }
}
