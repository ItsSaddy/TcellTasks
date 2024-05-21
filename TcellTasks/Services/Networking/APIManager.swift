//
//  APIManager.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 08/05/24.
//

import Moya
import Foundation

final class APIManager {
    static let shared = APIManager()
    
    private let networking: Networking = Networking.defaultNetworking()
    
    private func requestWithoutObject(_ target: API, completion: @escaping (Result<Response, MoyaError>) -> Void) {
        networking.provider.request(target, completion: completion)
    }
    
    private func requestObject<T: Decodable>(_ target: API, completion: @escaping (Result<T, MoyaError>) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd'T'HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        networking.provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let mappedResponse = try filteredResponse.map(T.self, using: decoder)
                    completion(.success(mappedResponse))
                }
                catch let error {
                    completion(.failure(error as! MoyaError))
                }
            case let .failure(error):
                completion(.failure(error))
            }
            
        }
    }
}

extension APIManager {
    func login(email: String, password: String, completion: @escaping (Result<TokenResponse, MoyaError>) -> Void) {
        requestObject(.login(email: email, password: password), completion: completion)
    }
    
    func task(by stateID: Int, completion: @escaping (Result<TaskListResponse, MoyaError>) -> Void) {
        requestObject(.task(stateID: stateID), completion: completion)
    }
    
    func completeTask(
        id: Int,
        images: [Data],
        comment: String,
        isGoToPlaceRequired: Int,
        state: Int,
        completion: @escaping (Result<Response, MoyaError>) -> Void
    ) {
        requestWithoutObject(.completeTask(
            id: id,
            images: images,
            comment: comment,
            isGoToPlaceRequired: isGoToPlaceRequired,
            state: state),
                      completion: completion
        )
    }
    
    func startTask(id: Int, stateID: Int, completion: @escaping  (Result<Response, MoyaError>) -> Void) {
        requestWithoutObject(.startTask(id: id, state: stateID), completion: completion)
    }
}
