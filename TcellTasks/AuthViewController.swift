//
//  AuthViewController.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 02/05/24.
//

import UIKit

class AuthViewController: UIViewController {
    static func storyboardInstance() -> AuthViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? AuthViewController
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var authButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: StoryboardID.auth.id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//MARK: - SetupViews
extension AuthViewController {
    func setupViews() {
        authButton.layer.cornerRadius = 5
    }
}

