//
//  KeychainService.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 14/05/24.
//

import KeychainSwift

final class KeychainService {
    static let shared = KeychainService()
    
    private let keychain = KeychainSwift()
    
    private init() {
        
    }
    
    var token: String? {
        get {
            keychain.get(Key.token)
        }
        set {
            guard let token = newValue else { return }
            
            keychain.set(token, forKey: Key.token)
        }
    }
    
    struct Key {
        static let token = "token"
    }
    
    func clear() {
        keychain.clear()
    }
}


