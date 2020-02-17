//
//  QRCodeScannerStrings.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 2/17/20.
//  Copyright © 2020 Djordje Ljubinkovic. All rights reserved.
//

import Foundation

enum QRCodeScannerStrings: String, Localizable {
    case navigationTitle
    case signatureValidTitle
    case okAlertAction
    
    var tableName: String {
        return "QRCodeScanner"
    }
}
