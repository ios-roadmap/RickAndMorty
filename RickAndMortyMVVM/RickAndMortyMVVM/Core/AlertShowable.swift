//
//  AlertShowable.swift
//  RickAndMortyMVVM
//
//  Created by Ömer Faruk Öztürk on 4.08.2025.
//

import UIKit

protocol AlertShowable {
    func showAlert(_ message: String, completion: VoidHandler?)
    func showAndDismissAlert(_ message: String, completion: @escaping () -> ())
    func showConfirmationAlert(_ message: String, completion: @escaping () -> ())
}

extension AlertShowable where Self: UIViewController {
    func showAlert(_ message: String, completion: VoidHandler? = nil) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Tamam", style: .default) { _ in
            completion?()
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAndDismissAlert(_ message: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alert.dismiss(animated: true) {
                completion()
            }
        }
    }

    func showConfirmationAlert(_ message: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Vazgeç", style: .destructive))
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { _ in
            completion()
        }))
        present(alert, animated: true, completion: nil)
    }
}
