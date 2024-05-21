//
//  NetworkingType.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 15/05/24.
//

import Foundation
import Moya

protocol NetworkingType {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
}

extension NetworkingType {
    static func endpointsClosure<T>() -> (T) -> Endpoint where T: TargetType {
        return { target in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            return endpoint
        }
    }
    
    static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
        return .never
    }
    
    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        plugins.append(NetworkLoggerPlugin.verbose)
        return plugins
    }
    
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest()
                request.httpShouldHandleCookies = true
                closure(.success(request))
            } catch {
                closure(.failure(.underlying(error, nil)))
            }
        }
    }
}
