//
//  MoreScreenViewController.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 23/05/24.
//

import Foundation
import UIKit

class MoreScreenViewController: UIViewController {
    override func viewDidLoad() {
        setupViews()
    }

    //MARK: - @IBActions
    @IBAction func exitTapButton(_ sender: UIButton) {
        let alertLogout = UIAlertController(
            title: "Выход",
            message: "Вы действительно хотите выйти?",
            preferredStyle: .alert
        )
        
        let alertExitButton = UIAlertAction(title: "Выйти", style: .destructive) { _ in
            
            AuthenticationService.shared.state.value = .unauthenticated
        }
        let alertCancelButton = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertLogout.addAction(alertCancelButton)
        alertLogout.addAction(alertExitButton)
        
        present(alertLogout, animated: true)
    }
}

//MARK: - Extensions
extension MoreScreenViewController {
    func setupViews() {
        title = "Еще"
    }
}
