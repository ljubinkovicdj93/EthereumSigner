//
//  VerificationStrings.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 2/17/20.
//  Copyright © 2020 Djordje Ljubinkovic. All rights reserved.
//

import Foundation

enum VerificationStrings: String, Localizable {
    case navigationTitle
    case verifyMessageButtonTitle
    case textFieldPlaceholder
    
    var tableName: String {
        return "Verification"
    }
}
