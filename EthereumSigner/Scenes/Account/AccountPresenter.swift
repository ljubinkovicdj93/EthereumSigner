//
//  AccountPresenter.swift
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

protocol AccountPresentationLogic {
    func presentSomething(_ response: Account.Something.Response)
}

class AccountPresenter: AccountPresentationLogic {
    
    weak var viewController: AccountDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(_ response: Account.Something.Response) {
        let viewModel = Account.Something.ViewModel()
        viewController?.displaySomething(viewModel)
    }
}