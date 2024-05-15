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
    var date: Date
}


enum TaskState: Int, Decodable, CaseIterable {
    case notClosed = 0
    case success = 1
    case inProgress = 2
    case onApproval = 4
    
    var title: String {
        switch self {
        case .notClosed:
            return "Активные"
        case .success:
            return "Выполненные"
        case .inProgress:
            return "В процессе"
        case .onApproval:
            return "В одобрении"
        }
    }
}
