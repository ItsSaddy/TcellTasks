//
//  AuthInterceptor.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 15/05/24.
//

import Foundation
import Alamofire

class AuthInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        
        if let token = KeychainService.shared.token {
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        }
        completion(.success(request))
        
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        print(request.response)
        if request.response?.statusCode == 401 {
            KeychainService.shared.clear()
            AuthenticationService.shared.state.value = .unauthenticated
            completion(.doNotRetry)
        }
    }
}
