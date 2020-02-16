//
//  SetupModels.swift
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

struct Setup {
    // MARK: Use cases
    
    struct InitialState {
        struct Response {
            let maximumCharactersAllowed: MaximumCharactersAllowed
            let onTextDidChangeClosure: (String) -> Void
            let validationState: ValidationState = .none
        }
        
        struct ViewModel {
            var validationConfiguration: ValidationConfiguration
            let errorLabelStyle: UIViewStyle<UILabel>
            let buttonStyle: UIViewStyle<UIButton>
        }
    }
    
    struct Account {
        struct Request {
            let privateKeyText: String
        }
        
        struct Response {
            let wallet: Wallet
        }
        
        struct ViewModel {
            let accountAddress: String
            let walletBalance: String
        }
    }
    
    struct ValidationChange {
        struct Response {
            let validationState: ValidationState
            let maximumCharactersAllowed: MaximumCharactersAllowed
        }
        
        struct ViewModel {
            let errorLabelStyle: UIViewStyle<UILabel>
            let buttonStyle: UIViewStyle<UIButton>
            let validationState: ValidationState
            let maximumCharactersAllowed: MaximumCharactersAllowed
        }
    }
}
