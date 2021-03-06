//
//  QRCodeScannerRouter.swift
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

protocol QRCodeScannerRoutingNavigation {
    func showNewScreen()
    func showDismiss()
}

protocol QRCodeScannerDataPassing {
    var dataStore: QRCodeScannerDataStore? { get set }
    func passDataToNextScene(segue: UIStoryboardSegue)
}

typealias QRCodeScannerRouterInput = QRCodeScannerRoutingNavigation & QRCodeScannerDataPassing

class QRCodeScannerRouter: QRCodeScannerRouterInput {
    
    private struct Segues {
        static let ShowNextScreenIdentifier = ""
    }
    
    var dataStore: QRCodeScannerDataStore?
    weak var viewController: QRCodeScannerViewController?
    
    // MARK: Navigation
    
    func showNewScreen() {
        viewController?.performSegue(withIdentifier: Segues.ShowNextScreenIdentifier, sender: nil)
    }
    
    func showDismiss() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Passing data
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        if segue.identifier == Segues.ShowNextScreenIdentifier {
            // Pass Relevant Data
        }
    }
}
