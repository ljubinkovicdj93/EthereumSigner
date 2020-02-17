//
//  Localizable.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 2/17/20.
//  Copyright © 2020 Djordje Ljubinkovic. All rights reserved.
//

import UIKit

protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
}
