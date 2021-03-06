//
//  SetupInteractor.swift
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
import web3swift
import BigInt

protocol SetupBusinessLogic {
    func requestInitialState()
    func createAccount(_ request: Setup.Account.Request) throws
}

protocol SetupDataStore {
    var wallet: Wallet? { get set }
}

class SetupInteractor: SetupBusinessLogic, SetupDataStore {

    private struct Constants {
        static let HexCode = "0x"
        static let MaximumCharactersAllowed: Int = 64
        
        struct Error {
            static let Message: String = "Invalid private key. Enter at least 64 alphanumeric letters, or 66 if the first two are `0x`"
        }
    }
    
    var wallet: Wallet?
    
    var presenter: SetupPresentationLogic?
    lazy var worker: SetupWorker? = {
        return SetupWorker()
    }()
    
    // MARK: Business Logic
    
    func requestInitialState() {
        let privateKeyTextValidator = TextValidator.EthereumPrivateKeyValidator
        
        let onTextDidChangeClosure: (String) -> Void = { [weak self] text in guard let self = self else { return }
            let additionalCharacterCountToAllow = text.hasPrefix(Constants.HexCode) ? 2 : 0
            
            self.presenter?.presentValidationDidChange(Setup.ValidationChange.Response(validationState: privateKeyTextValidator.onValidate(text),
                                                                                       maximumCharactersAllowed: .limited(Constants.MaximumCharactersAllowed + additionalCharacterCountToAllow)))
        }
        
        presenter?.presentInitialState(Setup.InitialState.Response(maximumCharactersAllowed: .limited(Constants.MaximumCharactersAllowed), onTextDidChangeClosure: onTextDidChangeClosure, textValidator: privateKeyTextValidator))
    }
    
    func createAccount(_ request: Setup.Account.Request) throws {
//        let privateKey = "A6E4AF5B2B8323E965876D94D9CE635723A8A7193E61000D241CDDEAA613F3E4" // Some private key
        Web3Manager.shared.storePrivateKey(request.privateKeyText)
        
        do {
            let wallet = try Web3Manager.shared.getAccountAndBalance()
            self.wallet = wallet
            presenter?.presentAccountAndBalance(Setup.Account.Response(wallet: wallet))
        } catch {
            throw EthereumError.genericError(error.localizedDescription)
        }
    }
}
