//
//  API.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 08/05/24.
//

import Moya
import Foundation

public enum API {
    case login(email: String, password: String)
    case task(stateID: Int)
    case completeTask(id: Int, images: [Data], comment: String, isGoToPlaceRequired: Int, state: Int)
    case startTask(id: Int, state: Int)
}

extension API: TargetType {
    public var baseURL: URL {
        return URL(string: "https://wfm.tcell.tj/api/v1/")!
    }
    
    public var path: String {
        var path: String
        
        switch self {
        case .login:
            path = "login/"
        case let .task(stateID):
            path = "applications/\(stateID)/"
        case .completeTask, .startTask:
            path = "application/start/"
        }
        
        return path
    }
    
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .task:
            return .get
        case .completeTask, .startTask:
            return .put
        }
    }
    
    public var task: Moya.Task {
        let encoding = JSONEncoding.default
        
        switch self {
        case let .login(email, password):
            return .requestParameters(parameters: [
                "email": email,
                "password" : password
            ], encoding: encoding)
        case .task:
            return .requestPlain
        case let .startTask(id, stateID):
            return .requestParameters(parameters: ["id": id, "state": stateID], encoding: URLEncoding.httpBody)
        case let .completeTask(id, images, comment, isGoToPlaceRequired, state):
            var multipartData: [MultipartFormData] = images.map({ imageData in
                MultipartFormData(
                    provider: .data(imageData),
                    name: "images",
                    fileName: "photo.jpg",
                    mimeType: "image/jpeg"
                )
            })
            
            if let idData = id.description.data(using: .utf8) {
                multipartData.append(.init(provider: .data(idData), name: "id"))
            }
            
            if let commentData = comment.data(using: .utf8) {
                multipartData.append(.init(provider: .data(commentData), name: "comment"))
            }
            
            if let isGoToPlaceRequiredData = isGoToPlaceRequired.description.data(using: .utf8) {
                multipartData.append(.init(provider: .data(isGoToPlaceRequiredData), name: "is_go_to_place_required"))
            }
            
            if let stateData = state.description.data(using: .utf8) {
                multipartData.append(.init(provider: .data(stateData), name: "state"))
            }
            
            return .uploadMultipart(multipartData)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
