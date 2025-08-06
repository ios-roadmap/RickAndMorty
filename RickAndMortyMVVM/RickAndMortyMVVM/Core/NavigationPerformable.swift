//
//  NavigationPerformable.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import UIKit

@MainActor
protocol Navigationable {
    func navigate(to viewController: UIViewController, animated: Bool)
}

extension Navigationable where Self: UIViewController {
    func navigate(to viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func navigateToBack() {
        navigationController?.popViewController(animated: true)
    }
}
