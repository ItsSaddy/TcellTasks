//
//  StoryboardID.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 02/05/24.
//

import Foundation

enum StoryboardID {
    case auth
    
    var id: String {
        switch self {
        case .auth:
            "AuthViewController"
        }
    }
}
