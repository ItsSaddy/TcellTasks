//
//  PreviewViewController.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 21/05/24.
//

import Foundation
import UIKit

class PreviewViewController: UIViewController {
    
    static func storyboardInstance() -> PreviewViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: String(describing: self)) as! PreviewViewController
    }
    
    @IBOutlet weak var previewImage: UIImageView!
    
    var photo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

//MARK: - SetupViews
extension PreviewViewController {
    func setupViews() {
        previewImage.image = photo
        previewImage.clipsToBounds = true
    }
}
