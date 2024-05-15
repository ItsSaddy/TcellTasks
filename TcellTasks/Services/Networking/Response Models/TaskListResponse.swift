//
//  TaskListResponse.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 13/05/24.
//

import Foundation

struct TaskListResponse: Decodable {
    let fullName: String
    let data: [TaskResponse]
}
