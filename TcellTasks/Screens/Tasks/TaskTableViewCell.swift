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
    @IBOutlet weak var objectLabel: UILabel!
    @IBOutlet weak var workTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var numberIdLabel: UILabel!
    @IBOutlet weak var moreVStack: UIStackView!
    @IBOutlet weak var moreInfoImage: UIImageView!
    @IBOutlet weak var goToTaskButton: UIButton!
    @IBOutlet weak var moreVStackHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func configure(task: TaskResponse, isMoreInfoHidden: Bool) {
        setup(task: task)
        calculateMoreInfoLayout(with: isMoreInfoHidden)
    }
    
    private func setup(task: TaskResponse) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        objectLabel.text = task.obj
        workTypeLabel.text = task.workType
        dateLabel.text = dateFormatter.string(from: task.date)
        numberIdLabel.text = task.id.description
        
    }
    
    private func calculateMoreInfoLayout(with isMoreInfoHidden: Bool) {
        moreVStack.isHidden = isMoreInfoHidden
        
        if isMoreInfoHidden {
            moreVStackHeight.constant = 0
            moreInfoImage.image = UIImage(systemName: "chevron.down")
        }
        else {
            moreVStackHeight.constant = 230
            moreInfoImage.image = UIImage(systemName: "chevron.up")
        }
        
        layoutIfNeeded()
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
