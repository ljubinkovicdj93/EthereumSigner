//
//  SignatureStrings.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 2/17/20.
//  Copyright © 2020 Djordje Ljubinkovic. All rights reserved.
//

import Foundation

enum SignatureStrings: String, Localizable {
    case navigationTitle
    case messageLabelTitle
    
    var tableName: String {
        return "Signature"
    }
}
