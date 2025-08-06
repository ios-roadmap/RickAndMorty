//
//  IndicatorShowable.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 6.08.2025.
//

import UIKit

@MainActor
protocol IndicatorShowable {
    func showIndicator(_ indicatorView: UIActivityIndicatorView)
    func hideIndicator(_ indicatorView: UIActivityIndicatorView)
}

extension IndicatorShowable where Self: UIViewController {
    
    func showIndicator(_ indicatorView: UIActivityIndicatorView) {
        view.addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        indicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        indicatorView.startAnimating()
    }
    
    func hideIndicator(_ indicatorView: UIActivityIndicatorView) {
        indicatorView.stopAnimating()
    }
}
