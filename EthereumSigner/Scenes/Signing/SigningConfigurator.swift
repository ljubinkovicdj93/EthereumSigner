//
//  SigningConfigurator.swift
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

extension SigningViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.passDataToNextScene(segue: segue)
    }
}

// MARK: - Connects View, Interactor, and Presenter
class SigningConfigurator {
    
    static let sharedInstance = SigningConfigurator()
    
    private init() {}
    
    // MARK: - Configuration
    
    func configure(_ viewController: SigningViewController) {
        let presenter = SigningPresenter()
        presenter.viewController = viewController
        
        let interactor = SigningInteractor()
        interactor.presenter = presenter
        
        let router = SigningRouter()
        router.viewController = viewController
        router.dataStore = interactor
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
