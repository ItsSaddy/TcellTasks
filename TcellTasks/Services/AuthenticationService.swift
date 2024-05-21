//
//  AuthenticationService.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 15/05/24.
//

import Foundation

final class AuthenticationService {
    static let shared = AuthenticationService()
    
    private init() {}
    
    var state: Box<State> = .init(.idle)
    
    enum State {
        case idle
        case authenticated
        case unauthenticated
    }
}

class Box<T> {
    typealias Listener = (T) -> Void
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: Listener?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
