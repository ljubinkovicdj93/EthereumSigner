//
//  SigningInteractor.swift
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

protocol SigningBusinessLogic {
    func requestInitialState()
    func signMessage(_ request: Signing.Signature.Request)
}

protocol SigningDataStore {
    var signedMessage: String { get set }
    var imageData: Data? { get set }
}

class SigningInteractor: SigningBusinessLogic, SigningDataStore {
    
    var signedMessage: String = .empty
    var imageData: Data?
    
    var presenter: SigningPresentationLogic?
    lazy var worker: SigningWorker? = {
        return SigningWorker()
    }()
    
    // MARK: Business Logic
    
    func requestInitialState() {
        let privateKeyTextValidator = TextValidator.NonEmptyTextValidator
        
        let onTextDidChangeClosure: (String) -> Void = { [weak self] text in guard let self = self else { return }
            self.presenter?.presentValidationDidChange(Signing.ValidationChange.Response(validationState: privateKeyTextValidator.onValidate(text)))
        }
        
        presenter?.presentInitialState(Signing.InitialState.Response(onTextDidChangeClosure: onTextDidChangeClosure, textValidator: privateKeyTextValidator))
    }
    
    func signMessage(_ request: Signing.Signature.Request) {
        signedMessage = request.signedMessage
        imageData = worker?.signedMessageData(signedMessage)
        
        presenter?.presentSignMessage()
    }
}
