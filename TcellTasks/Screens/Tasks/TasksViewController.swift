//
//  TasksViewController.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 02/05/24.
//

import UIKit

class TasksViewController: UIViewController {
    static func storyboardInstance() -> TasksViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: String(describing: self)) as? TasksViewController
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    private var expandedCells: Set<IndexPath> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
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
    }
}

//MARK: - SetupViews
private extension TasksViewController {
    func setupViews() {
        title = "Задачи"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TaskTableViewCell.nib, forCellReuseIdentifier: TaskTableViewCell.identifier)
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as! TaskTableViewCell
        cell.isMoreInformationHidden = !expandedCells.contains(indexPath)
        return cell
    }
    
    
}
