//
//  CharactersViewController.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import UIKit

@MainActor
protocol CharactersViewControllerInterface: AnyObject {
    func prepareCollectionView()
    func setBackgroundColor(_ color: UIColor)
    
    func preFetch()
    func fetchLoaded()
    func fetchFailed(message: String)
}

final class CharactersViewController: UIViewController,
                                      AlertShowable,
                                      IndicatorShowable,
                                      Navigationable {
    
    enum Constants {
        enum Spacing {
            static let _4px: CGFloat = 4
        }
    }
    
    private lazy var collectionView: UICollectionView = .init()
    
    private lazy var indicatorView = UIActivityIndicatorView(style: .large)
    
    private lazy var viewModel = CharactersViewModel(
        viewController: self,
        service: LiveRMService()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task { [weak self] in
            await self?.viewModel.viewDidLoad()
        }
    }
}

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.identifier,
            for: indexPath
        ) as? CharacterCollectionViewCell else {
            fatalError()
        }
        
        viewModel.configure(cell: cell, at: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.view.frame.width / 2) - 12
        return CGSize(width: size, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.Spacing._4px
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.willDisplayItem(at: indexPath.row)
    }
}

extension CharactersViewController: CharactersViewControllerInterface {
    func prepareCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
    
    func preFetch() {
        showIndicator(indicatorView)
    }
    
    func fetchLoaded() {
        hideIndicator(indicatorView)
        collectionView.reloadData()
    }
    
    func fetchFailed(message: String) {
        indicatorView.stopAnimating()
        showAlert(message, completion: { [weak self] in
            self?.navigateToBack()
        })
    }
}
