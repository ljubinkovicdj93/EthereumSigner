//
//  SigningStrings.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 2/17/20.
//  Copyright © 2020 Djordje Ljubinkovic. All rights reserved.
//

import Foundation

enum SigningStrings: String, Localizable {
    case navigationTitle
    case signMessageButtonTitle
    case textFieldPlaceholder
    
    var tableName: String {
        return "Signing"
    }
}
