//
//  SignatureInteractor.swift
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

protocol SignatureBusinessLogic {
    func doSomething(_ request: Signature.Something.Request)
}

protocol SignatureDataStore {
    //var name: String { get set }
}

class SignatureInteractor: SignatureBusinessLogic, SignatureDataStore {
    
    var presenter: SignaturePresentationLogic?
    lazy var worker: SignatureWorker? = {
        return SignatureWorker()
    }()
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(_ request: Signature.Something.Request) {
        worker?.doSomeWork()
        
        let response = Signature.Something.Response()
        presenter?.presentSomething(response)
    }
}
