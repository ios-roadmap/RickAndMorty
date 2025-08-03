//
//  RMCharacterRouter.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import UIKit

final class RMCharacterRouter: RMCharacterRouterProtocol {
    
    weak var viewController: UIViewController!
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func navigateToDetail(with character: RMCharacter) {
        let homeVC = UIViewController()
        navigationController?.pushViewController(homeVC, animated: true)
    }
}


