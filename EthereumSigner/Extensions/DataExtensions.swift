//
//  DataExtensions.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 2/16/20.
//  Copyright © 2020 Djordje Ljubinkovic. All rights reserved.
//

import UIKit

extension Data {
    var qrCodeImage: UIImage? {
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(self, forKey: "inputMessage")
            
            let transform = CGAffineTransform(scaleX: 10.0, y: 10.0)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    // MARK: - Keychain related
    
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
