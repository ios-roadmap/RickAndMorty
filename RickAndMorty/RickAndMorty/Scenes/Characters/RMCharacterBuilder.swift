//
//  RMCharacterBuilder.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import UIKit

final class RMCharacterBuilder {
    
    static func build(navigationController: UINavigationController?) -> UIViewController {
        let view = RMCharacterViewController()
        let service: RMService = ServiceProvider(kind: .live)
        let interactor = RMCharacterInteractor(service: service)
        let presenter = RMCharacterPresenter()
        let router = RMCharacterRouter(navigationController: navigationController)
        
        view.presenter = presenter
        presenter.viewController = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
