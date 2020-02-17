//
//  LocalizedStrings.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 2/17/20.
//  Copyright © 2020 Djordje Ljubinkovic. All rights reserved.
//

import Foundation

enum SetupStrings: String, Localizable {
    case navigationTitle
    case nextButtonTitle
    case errorLabelTitle
    case textFieldPlaceholder
    
    var tableName: String {
        return "Setup"
    }
}
