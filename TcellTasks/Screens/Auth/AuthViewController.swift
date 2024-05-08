//
//  AuthViewController.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 02/05/24.
//

import UIKit

class AuthViewController: UIViewController {
    static func storyboardInstance() -> AuthViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: String(describing: self)) as? AuthViewController
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var authButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBAction func actionAuthButton(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }
        APIManager.shared.login(email: email,
                                password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                print(response.token)
                
                if let TasksViewController = TasksViewController.storyboardInstance() {
                    navigationController?.pushViewController(TasksViewController, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

//MARK: - SetupViews
extension AuthViewController {
    func setupViews() {
        authButton.layer.cornerRadius = 5
    }
}

