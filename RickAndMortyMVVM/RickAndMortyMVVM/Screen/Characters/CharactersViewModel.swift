//
//  RMViewModel.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import Foundation

@MainActor
protocol CharactersViewModelInterface {    
    func viewDidLoad()
    func numberOfItems() -> Int
    func configure(cell: CharacterCollectionViewCell, at index: Int)
    func willDisplayItem(at index: Int)
}

final class CharactersViewModel {
    
    private weak var viewController: CharactersViewControllerInterface?
    
    init(viewController: CharactersViewControllerInterface) {
        self.viewController = viewController
    }
    
    var page: Int = 1
    var isPageRefreshing: Bool = false
    
    private var characterInfo: RMCharacterInfo?
    private var characters: [RMCharacter] = []
    
    private var rmService = APIClient<RMEndpoint>()
    
    private func fetchCharacters(page: Int = 1) async {
        await viewController?.preFetch()
        
        do {
            let rmCharacters: RMCharacters = try await rmService.request(.character(page: page == 1 ? nil : page))
            characterInfo = rmCharacters.info
            characters += rmCharacters.results ?? []
            
            await MainActor.run {
                viewController?.fetchLoaded()
                
                guard characters.isEmpty else {
                    return
                }
                
                viewController?.fetchFailed(message: "Fetch an empty data")
            }
        } catch {
            await viewController?.fetchFailed(message: error.localizedDescription)
        }
    }
}

extension CharactersViewModel: CharactersViewModelInterface {
    func viewDidLoad() {
        viewController?.prepareCollectionView()
        viewController?.setBackgroundColor(.systemBackground)
        
        Task {
            await fetchCharacters()
        }
    }
    
    func numberOfItems() -> Int {
        characters.count
    }
    
    func configure(cell: CharacterCollectionViewCell, at index: Int) {
        guard index < characters.count else { return }
        cell.configure(with: characters[index])
    }
    
    func willDisplayItem(at index: Int) {
        if index == characters.count - 1, page < characterInfo?.pages ?? 0 {
            page += 1
            Task {
                await fetchCharacters(page: page)
            }
        }
    }
}
