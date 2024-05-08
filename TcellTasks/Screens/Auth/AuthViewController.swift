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
    @IBOutlet weak var authButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    @IBAction func actionAuthButton(_ sender: UIButton) {
        
        if let TasksViewController = TasksViewController.storyboardInstance() {
                navigationController?.pushViewController(TasksViewController, animated: true)
            }
    }
    
    
}

//MARK: - SetupViews
extension AuthViewController {
    func setupViews() {
        authButton.layer.cornerRadius = 5
    }
}

