//
//  GithubViewController.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import UIKit
import Kingfisher

@MainActor
protocol GithubViewControllerInterface: AnyObject {
    func didLoad()
    func didLayoutSubviews()
    func navigateToCharacters()
    
    func preFetch()
    func fetchLoaded(response: GithubUser)
    func fetchFailed(message: String)
}

final class GithubViewController: UIViewController,
                                  Navigationable,
                                  IndicatorShowable,
                                  AlertShowable {
    
    private lazy var indicatorView = UIActivityIndicatorView(style: .large)
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 12
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.borderWidth = 3.0
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    lazy var usernameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 24, weight: .bold)
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 17, weight: .regular)
        return view
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(rickAndMortyButton)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .leading
        view.distribution = .fill
        view.spacing = 12
        return view
    }()
    
    lazy var rickAndMortyButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Rick And Morty", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var viewModel = GithubViewModel(
        viewController: self,
        service: LiveGithubService()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        viewModel.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        viewModel.viewDidLayoutSubviews()
    }
}

extension GithubViewController: GithubViewControllerInterface {
   func didLoad() {
        rickAndMortyButton.addTarget(self, action: #selector(navigateToCharacters), for: .touchUpInside)

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(horizontalStackView)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    func didLayoutSubviews() {
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
    }
    
    func preFetch() {
        showIndicator(indicatorView)
    }
    
    func fetchLoaded(response: GithubUser) {
        hideIndicator(indicatorView)
        
        if let avatarUrl = response.avatarUrl, let url = URL(string: avatarUrl) {
            imageView.kf.setImage(with: url)
        }

        if let username = response.login {
            usernameLabel.text = username
        }

        if let bio = response.bio {
            descriptionLabel.text = bio
        }
    }
    
    func fetchFailed(message: String) {
        hideIndicator(indicatorView)
        showAlert(message)
    }
    
    @objc func navigateToCharacters() {
        navigate(to: CharactersViewController())
    }
}
