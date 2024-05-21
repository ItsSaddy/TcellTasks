//
//  TaskTableViewCell.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 03/05/24.
//

import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    func taskButtonTapped(task: TaskResponse)
}

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
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var moreVStackHeight: NSLayoutConstraint!
    
    weak var delegate: TaskTableViewCellDelegate?
    private var task: TaskResponse?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func configure(task: TaskResponse, isMoreInfoHidden: Bool) {
        setup(task: task)
        calculateMoreInfoLayout(with: isMoreInfoHidden)
    }
    
    private func setup(task: TaskResponse) {
        self.task = task
        
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
    
    @IBAction func taskButtonTapped(_ sender: UIButton) {
        guard let task = task else { return }
        
        delegate?.taskButtonTapped(task: task)
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
        
        taskButton.layer.cornerRadius = 8
    }
}
