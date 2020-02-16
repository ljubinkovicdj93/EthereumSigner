//
//  SigningModels.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 08/02/2020.
//  Copyright (c) 2020 Djordje Ljubinkovic. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

struct Signing {
    // MARK: Use cases
    
    struct Signature {
        struct Request {
            let signedMessage: String
        }
        
        typealias Response = Request
        typealias ViewModel = Response
    }
}
