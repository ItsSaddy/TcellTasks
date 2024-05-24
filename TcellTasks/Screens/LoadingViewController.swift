//
//  LoadingViewController.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 24/05/24.
//

import UIKit

class LoadingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cardView = UIView()
        cardView.backgroundColor = .systemBackground
        cardView.layer.cornerRadius = 8
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(cardView)
        cardView.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            blurEffectView.leftAnchor.constraint(equalTo: view.leftAnchor),
            blurEffectView.rightAnchor.constraint(equalTo: view.rightAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cardView.widthAnchor.constraint(equalToConstant: 100),
            cardView.heightAnchor.constraint(equalToConstant: 100),
            cardView.centerXAnchor.constraint(equalTo: blurEffectView.contentView.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: blurEffectView.contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadingIndicator.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 16),
            loadingIndicator.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -16),
            loadingIndicator.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            loadingIndicator.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
        ])
    }
}
