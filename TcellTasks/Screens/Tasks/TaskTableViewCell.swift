//
//  TaskTableViewCell.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 03/05/24.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    static let identifier = String(describing: TaskTableViewCell.self)
    
    static let nib: UINib = {
        UINib(nibName: TaskTableViewCell.identifier, bundle: nil)
    }()
    
    //MARK: - @IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var moreVStack: UIStackView!
    @IBOutlet weak var moreInformationImage: UIImageView!
    @IBOutlet weak var goToTaskButton: UIButton!
    
    @IBOutlet weak var moreVStackHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    var isMoreInformationHidden: Bool = true {
        didSet {
            moreVStack.isHidden = isMoreInformationHidden
            
            if isMoreInformationHidden {
                moreVStackHeight.constant = 0
                moreInformationImage.image = UIImage(systemName: "chevron.down")
            }
            else {
                moreVStackHeight.constant = 180
                moreInformationImage.image = UIImage(systemName: "chevron.up")
            }
            
            layoutIfNeeded()
        }
    }
}

//MARK: - SetupViews
extension TaskTableViewCell {
    func setupViews() {
        selectionStyle = .none
        
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        
        goToTaskButton.layer.cornerRadius = 8
    }
}
