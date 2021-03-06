//
//  QRCodeScannerModels.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 08/02/2020.
//  Copyright (c) 2020 Djordje Ljubinkovic. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import AVFoundation
import UIKit

struct QRCodeScanner {
    // MARK: Use cases
    
    struct CaptureSession {
        struct Response {
            let captureSession: AVCaptureSession
        }
        
        typealias ViewModel = Response
    }
    
    struct Validation {
        struct Request {
            let qrCodeStringValue: String
        }
        
        struct Response {
            let result: Swift.Result<String, EthereumError>
        }
        
        struct ViewModel {
            let title: String
        }
    }
}
