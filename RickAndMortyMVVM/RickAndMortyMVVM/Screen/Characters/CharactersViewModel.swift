//
//  RMViewModel.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import Foundation

@MainActor
protocol CharactersViewModelInterface {    
    func viewDidLoad() async
    func numberOfItems() -> Int
    func configure(cell: CharacterCollectionViewCell, at index: Int)
    func willDisplayItem(at index: Int) async
}

final class CharactersViewModel {
    
    private weak var viewController: CharactersViewControllerInterface?
    private var rmService: RMServiceInterface
    
    init(
        viewController: CharactersViewControllerInterface,
        service: LiveRMService
    ) {
        self.viewController = viewController
        self.rmService = service
    }
    
    private var page: Int = 1
    private var isPageRefreshing: Bool = false // UIRefreshController
    
    private var characterInfo: RMCharacterInfo?
    private var characters: [RMCharacter] = []
    
    private func fetchCharacters(page: Int = 1) async {
        await viewController?.preFetch()
        
        await rmService.fetchCharacters(page: page <= 1 ? nil : page) { [weak self] result in
            guard let self else { return }
            
            Task { [weak self] in
                guard let self else { return }
                
                switch result {
                case .success(let rmCharacters):
                    await didFetchCharacters(rmCharacters: rmCharacters)
                case .failure(let error):
                    await didFailedFetch(error: error)
                }
            }
        }
    }
    
    func didFetchCharacters(rmCharacters: RMCharacters) async {
        characterInfo = rmCharacters.info
        
        let newResults = rmCharacters.results ?? []
        characters.append(contentsOf: newResults)
        
        characters += rmCharacters.results ?? []
        print("characters: \(characters.count)")
        
        if characters.isEmpty {
            guard characters.isEmpty else {
                return
            }
            
            await viewController?.fetchFailed(message: "Fetch an empty data")
        } else {
            await self.viewController?.fetchLoaded()
        }
    }
    
    func didFailedFetch(error: Error) async {
        await viewController?.fetchFailed(message: error.localizedDescription)
    }
}

extension CharactersViewModel: CharactersViewModelInterface {
    func viewDidLoad() async {
        viewController?.prepareCollectionView()
        viewController?.setBackgroundColor(.systemBackground)
        
        await fetchCharacters()
    }
    
    func numberOfItems() -> Int {
        characters.count
    }
    
    func configure(cell: CharacterCollectionViewCell, at index: Int) {
        guard index < characters.count else { return }
        cell.configure(with: characters[index])
    }
    
    func willDisplayItem(at index: Int) {
        Task { [weak self] in
            guard let self else { return }
            if index == characters.count - 1, page < characterInfo?.pages ?? 0 {
                page += 1
                await fetchCharacters(page: page)
            }
        }
    }
}
