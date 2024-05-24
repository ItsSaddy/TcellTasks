//
//  TaskDetailController.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 14/05/24.
//

import Moya
import Foundation
import UIKit

class TaskDetailController: UIViewController  {
    @IBOutlet weak var workTypeLabel: UILabel!
    @IBOutlet weak var objectLabel: UILabel!
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numberIdLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var task: TaskResponse?
    var state: TaskState?
    
    static func storyboardInstance() -> TaskDetailController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: String(describing: self)) as! TaskDetailController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupViews()
    }
    
    @IBAction func taskButtonAction(_ sender: UIButton) {
        guard let task = task else { return }
        switch task.state {
        case .notClosed:
            APIManager.shared.startTask(id: task.id, stateID: TaskState.inProgress.rawValue) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(_):
                    self.task?.state = .inProgress
                    setupData()
                case let .failure(error):
                    print(error)
                }
            }
        case .inProgress:
            let nextViewController = CompleteTaskViewController.storyboardInstance()
            nextViewController.task = task
            navigationController?.pushViewController(nextViewController, animated: true)
        default:
            break
        }
    }
}

//MARK: - SetupViews
private extension TaskDetailController {
    func setupViews() {
    }
}
//MARK: - SetupData
private extension TaskDetailController {
    func setupData() {
        guard let task = task else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        objectLabel.text = task.obj
        workTypeLabel.text = task.workType
        dateLabel.text = dateFormatter.string(from: task.date)
        numberIdLabel.text = task.id.description
        descriptionLabel.text = task.description
        
        switch task.state {
        case .notClosed:
            taskButton.setTitle("Начать", for: .normal)
            taskButton.backgroundColor = .primary
        case .success, .successZIP:
            taskButton.isHidden = true
        case .inProgress:
            taskButton.backgroundColor = .systemGreen
            taskButton.setTitle("Завершить", for: .normal)
        case .onApproval, .closedZIP:
            taskButton.isUserInteractionEnabled = false
            taskButton.backgroundColor = .gray
            taskButton.setTitle("В одобрении", for: .normal)
        }
    }
}

