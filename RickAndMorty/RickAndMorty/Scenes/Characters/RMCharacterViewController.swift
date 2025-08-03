//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import UIKit

final class RMCharacterViewController: UIViewController {
    
    var presenter: RMCharacterPresenterProtocol!

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        view.backgroundColor = .systemBackground
        
        presenter?.viewDidLoad()
    }
}

extension RMCharacterViewController: RMCharacterViewControllerProtocol {
    
    func showLoading() {
        print("Loading...")
    }
    
    func hideLoading() {
        print("Hiding...")
    }
    
    func reloadData() {
        print("Reloading...")
    }
    
    func showError(_ message: String) {
        print("Error...")
    }
}
