//
//  ImageCollectionViewCell.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 20/05/24.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = String(describing: ImageCollectionViewCell.self)
    
    static let nib: UINib = {
        UINib(nibName: ImageCollectionViewCell.identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
    }

}

