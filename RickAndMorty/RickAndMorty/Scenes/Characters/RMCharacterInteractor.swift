//
//  RMCharacterInteractor.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import Foundation
import Combine

final class RMCharacterInteractor: RMCharacterInteractorProtocol {
    
    weak var presenter: RMCharacterInteractorOutputProtocol!
    private var cancellables = Set<AnyCancellable>()
    private let service: RMService
    
    init(service: RMService) {
        self.service = service
    }
    
    func fetchCharacters() {
        service.fetchCharacters()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.presenter?.didFailWithError(error)
            } receiveValue: { [weak self] response in
                self?.presenter?.didFetchCharacters(response)
            }
            .store(in: &cancellables)
    }
}
