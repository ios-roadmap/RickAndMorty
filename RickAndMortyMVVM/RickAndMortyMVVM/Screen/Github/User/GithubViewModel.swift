//
//  GithubViewModel.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 6.08.2025.
//

import Foundation

@MainActor
protocol GithubViewModelInterface {
    func viewDidLoad()
    func viewDidLayoutSubviews()
    func rickAndMortyButtonTapped()
}

final class GithubViewModel {
    
    private weak var viewController: GithubViewControllerInterface?
    private var service: GithubServiceInterface?
    
    init(
        viewController: GithubViewControllerInterface,
        service: GithubServiceInterface
    ) {
        self.viewController = viewController
        self.service = service
    }
    
    func getUsers() async {
        await viewController?.preFetch()
        
        await service?.getUser(userName: "ozturkomerfaruk") { [weak self] result in
            guard let self else { return }
            
            Task { [weak self] in
                guard let self else { return }
                
                switch result {
                case .success(let user):
                    await viewController?.fetchLoaded(response: user)
                case .failure(let error):
                    await viewController?.fetchFailed(message: error.localizedDescription)
                }
            }
        }
    }
        
}

extension GithubViewModel: GithubViewModelInterface {
    
    func viewDidLoad() {
        viewController?.didLoad()
        Task {
            await getUsers()
        }
    }
    
    func viewDidLayoutSubviews() {
        viewController?.didLayoutSubviews()
    }
    
    func rickAndMortyButtonTapped() {
        viewController?.navigateToCharacters()
    }
}
