//
//  VerificationPresenter.swift
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

protocol VerificationPresentationLogic {
    func presentSomething(_ response: Verification.Something.Response)
}

class VerificationPresenter: VerificationPresentationLogic {
    
    weak var viewController: VerificationDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(_ response: Verification.Something.Response) {
        let viewModel = Verification.Something.ViewModel()
        viewController?.displaySomething(viewModel)
    }
}
