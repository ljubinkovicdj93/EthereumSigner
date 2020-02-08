//
//  SetupConfigurator.swift
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

extension SetupViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.passDataToNextScene(segue: segue)
    }
}

// MARK: - Connects View, Interactor, and Presenter
class SetupConfigurator {
    
    static let sharedInstance = SetupConfigurator()
    
    private init() {}
    
    // MARK: - Configuration
    
    func configure(_ viewController: SetupViewController) {
        let presenter = SetupPresenter()
        presenter.viewController = viewController
        
        let interactor = SetupInteractor()
        interactor.presenter = presenter
        
        let router = SetupRouter()
        router.viewController = viewController
        router.dataStore = interactor
        
        viewController.interactor = interactor
        viewController.router = router
    }
}