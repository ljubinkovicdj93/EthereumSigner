//
//  RoutingService.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 2/17/20.
//  Copyright © 2020 Djordje Ljubinkovic. All rights reserved.
//

import Foundation

final class RoutingService {
    static let shared = RoutingService()
    
    private init() {}
    
    enum RegistrationState {
        case privateKeyNotPresent
        case privateKeyExists(Data)
    }
    
    func resolveInitialState() -> RegistrationState {
        if let privateKeyData = KeychainManager.load(key: KeychainKey.ethereumPrivateKey.rawValue) {
            return .privateKeyExists(privateKeyData)
        }
        return .privateKeyNotPresent
    }
}
