//
//  API.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 08/05/24.
//

import Moya
import Foundation

enum API {
    case login(email: String, password: String)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://wfm.tcell.tj/api/v1/")!
    }
    
    var path: String {
        var path: String
        
        switch self {
        case .login:
            path = "login/"
        }
        
        return path
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: Moya.Task {
        let encoding = JSONEncoding.default
        
        switch self {
        case let .login(email, password):
            return .requestParameters(parameters: [
                "email": email,
                "password" : password
            ], encoding: encoding)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
