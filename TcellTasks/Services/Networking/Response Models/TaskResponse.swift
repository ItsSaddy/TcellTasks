//
//  TaskResponse.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 13/05/24.
//

import Foundation

struct TaskResponse: Decodable {
    let id: Int
    let workType: String
    let obj: String
    let date: Date
    let description: String
    var state: TaskState
}


enum TaskState: Int, Decodable, CaseIterable {
    case notClosed = 0
    case success = 1
    case inProgress = 2
    case closedZIP = 3
    case onApproval = 4
    case successZIP = 5
    
    var title: String {
        switch self {
        case .notClosed:
            return "Новые"
        case .success, .successZIP:
            return "Выполненные"
        case .inProgress:
            return "В процессе"
        case .onApproval, .closedZIP:
            return "В одобрении"
        }
    }
}
