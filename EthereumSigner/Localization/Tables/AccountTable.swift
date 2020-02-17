//
//  AccountTable.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 2/17/20.
//  Copyright © 2020 Djordje Ljubinkovic. All rights reserved.
//

import Foundation

enum AccountStrings: String, Localizable {
    case navigationTitle
    case addressLabel
    case balanceLabel
    case signButtonTitle
    case verifyButtonTitle
    
    var tableName: String {
        return "Account"
    }
}
