//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Ömer Faruk Öztürk on 3.08.2025.
//

import UIKit

final class RMCharacterViewController: UIViewController {
    
    var presenter: RMCharacterPresenterProtocol!
    
    let tableView: UITableView = .init()

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter?.viewDidLoad()
    }
    
    func setupUI() {
        title = "Characters"
        view.backgroundColor = .systemBackground
        
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            RMCharacterTableViewCell.self,
            forCellReuseIdentifier: RMCharacterTableViewCell.identifier
        )
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
        tableView.reloadData()
    }
    
    func showError(_ message: String) {
        print("Error...")
    }
}

extension RMCharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension RMCharacterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMCharacterTableViewCell.identifier, for: indexPath) as? RMCharacterTableViewCell else {
            fatalError()
        }
        
        let viewModel = presenter.createRMCharacterTableViewCellViewModel(at: indexPath.row)
        cell.configure(with: viewModel)
        return cell
    }
}
