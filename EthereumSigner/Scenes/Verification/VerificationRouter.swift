//
//  VerificationRouter.swift
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

protocol VerificationRoutingNavigation {
    func showQrCodeScanner()
}

protocol VerificationDataPassing {
    var dataStore: VerificationDataStore? { get set }
    func passDataToNextScene(segue: UIStoryboardSegue)
}

typealias VerificationRouterInput = VerificationRoutingNavigation & VerificationDataPassing

class VerificationRouter: VerificationRouterInput {
    
    private struct Segues {
        static let ShowQrCodeScannerIdentifier = "showQrCodeScanner"
    }
    
    var dataStore: VerificationDataStore?
    weak var viewController: VerificationViewController?
    
    // MARK: Navigation
    
    func showQrCodeScanner() {
        viewController?.performSegue(withIdentifier: Segues.ShowQrCodeScannerIdentifier, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        if segue.identifier == Segues.ShowQrCodeScannerIdentifier,
            let qrCodeScannerViewController = segue.destination as? QRCodeScannerViewController {
            
            qrCodeScannerViewController.router?.dataStore?.verificationMessage = dataStore?.verificationMessage
        }
    }
}
