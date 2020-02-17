//
//  ErrorsStrings.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 2/17/20.
//  Copyright © 2020 Djordje Ljubinkovic. All rights reserved.
//

import Foundation

enum ErrorsStrings: String, Localizable {
    case genericError
    case initializeKeystoreFail
    case invalidPrivateKey
    case noAccountAddressFound
    case noBalanceAvailable
    case invalidQrCode
    case cannotValidateQrCode
    
    var tableName: String {
        return "Errors"
    }
}
