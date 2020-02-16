//
//  Web3Manager.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 2/16/20.
//  Copyright © 2020 Djordje Ljubinkovic. All rights reserved.
//

import Foundation
import web3swift
import BigInt

enum EthereumError: Error {
    case genericError(String)
    case initializeKeystoreFail(String)
    case invalidPrivateKey(String)
    case noAccountAddressFound
    case noBalanceAvailable
}

class Web3Manager {
    static let shared = Web3Manager()
    
    private var privateKey: String?
//    {
//        get {
//            if Keychain.contains.privateKey {
//                return keychainPrivateKey
//            } else {
//                return nil
//            }
//        }
//    }
    private var accountAddress: String?
    
    lazy var provider: web3 = Web3.InfuraRinkebyWeb3()
    
    private init() {}
    
    func storePrivateKey(_ privateKey: String) {
        let formattedKey = privateKey.trimmingCharacters(in: .whitespacesAndNewlines)
        self.privateKey = formattedKey
    }
    
    func storeAccountAddress(_ accountAddress: String) {
        self.accountAddress = accountAddress
    }
    
    func getAccountAndBalance() throws -> Wallet {
        guard let privateKey = self.privateKey else { fatalError("Need to store private key first.") }
        
        guard let dataKey = Data.fromHex(privateKey) else { throw EthereumError.invalidPrivateKey(privateKey) }
        
        do {
            guard let keystore = try EthereumKeystoreV3(privateKey: dataKey) else { throw EthereumError.initializeKeystoreFail(dataKey.toHexString()) }
            guard let accountAddress = keystore.getAddress() else { throw EthereumError.noAccountAddressFound }
            guard let walletBalance = try? provider.eth.getBalance(address: accountAddress) else { throw EthereumError.noBalanceAvailable }
            
            storeAccountAddress(accountAddress.address)
            
            let wallet = Wallet(accountAddress: accountAddress.address, balance: walletBalance.formattedEthereumBalance)
            
            return wallet
        } catch {
            throw EthereumError.genericError(error.localizedDescription)
        }
    }
}

struct Wallet {
    let accountAddress: String
    let balance: String
}

extension BigUInt {
    var formattedEthereumBalance: String {
        guard let ethBalance = Web3.Utils.formatToEthereumUnits(self, toUnits: .eth, decimals: 10) else { return .empty }
        return "\(ethBalance) ETH"
    }
}
