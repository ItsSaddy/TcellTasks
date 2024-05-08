//
//  APIManager.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 08/05/24.
//

import Moya

final class APIManager {
    static let shared = APIManager()
    
    private let provider: MoyaProvider<API> = .init(plugins: [NetworkLoggerPlugin.verbose])
    
    private func requestObject<T: Decodable>(_ target: API,
                                        completion: @escaping (Result<T, MoyaError>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let mappedResponse = try filteredResponse.map(T.self)
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
}
