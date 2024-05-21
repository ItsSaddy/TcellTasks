//
//  Networking.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 15/05/24.
//

import Foundation
import Moya

struct Networking: NetworkingType {
    let provider: MoyaProvider<API>
    
    static func defaultNetworking() -> Networking {
        
        return Networking(provider: MoyaProvider(
            endpointClosure: Networking.endpointsClosure(),
            requestClosure: Networking.endpointResolver(),
            stubClosure: Networking.APIKeysBasedStubBehaviour,
            session: Session(interceptor: AuthInterceptor()),
            plugins: plugins))
    }
}
