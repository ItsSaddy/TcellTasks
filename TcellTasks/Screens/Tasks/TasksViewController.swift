//
//  TasksViewController.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 02/05/24.
//

import UIKit

class TasksViewController: UIViewController {
    static func storyboardInstance() -> TasksViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: String(describing: self)) as! TasksViewController
    }
    
    @IBOutlet weak var stateSegmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    private let loadingFooterView = LoadingFooterView()
    
    //MARK: - Properties
    private var expandedCells: Set<IndexPath> = .init()
    private var tasks: [TaskResponse] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getTasks()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: - IBActions
    
    @IBAction func segementedControlDidChange(_ sender: UISegmentedControl) {
        getTasks()
    }
}

//MARK: - SetupViews
private extension TasksViewController {
    func setupViews() {
        title = "Задачи"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = loadingFooterView
        tableView.register(TaskTableViewCell.nib, forCellReuseIdentifier: TaskTableViewCell.identifier)
        
        loadingFooterView.startAnimating()
        
        stateSegmentControl.removeAllSegments()
        
        TaskState.allCases.forEach { state in
            stateSegmentControl.insertSegment(withTitle: state.title,
                                              at: stateSegmentControl.numberOfSegments,
                                              animated: true)
        }
        stateSegmentControl.selectedSegmentIndex = 0
    }
}



//MARK: - UITableViewDelegate
extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if expandedCells.contains(indexPath) {
            expandedCells.remove(indexPath)
        }
        else {
            expandedCells.insert(indexPath)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
       
        
    }
}

//MARK: - UITableViewDataSource
extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as! TaskTableViewCell
        let row = indexPath.row
        
        cell.configure(task: tasks[row],
                       isMoreInfoHidden: !expandedCells.contains(indexPath))
        return cell
    }
    
    
}

//MARK: - Requests
private extension TasksViewController {
    func getTasks() {
        let selectedStateID = TaskState.allCases[stateSegmentControl.selectedSegmentIndex].rawValue
        
        loadingFooterView.startAnimating()
        
        APIManager.shared.task(by: selectedStateID) { [weak self] result in
            guard let self = self else { return }
            
            loadingFooterView.stopAnimating()
            
            switch result {
            case let .success(response):
                tasks = response.data
            case let .failure(error):
                print(error)
            }
        }
    }
}
