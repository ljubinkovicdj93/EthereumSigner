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
    case invalidQrCode(String)
    case cannotValidateQrCode(String)
}

class Web3Manager {
    static let shared = Web3Manager()
    
    private var privateKey: String? {
        didSet {
            guard let privateKey = self.privateKey else { return }
            self.privateKeyData = Data.fromHex(privateKey)
            
            if let privateKeyDataKeychain = privateKey.data(using: .utf8) {
                let _ = KeychainManager.save(key: KeychainKey.ethereumPrivateKey.rawValue, data: privateKeyDataKeychain)
            }

            try? storeKeystore()
        }
    }
    
    private var privateKeyData: Data?
    private var keystore: EthereumKeystoreV3?
    private var accountAddress: String?
    private var signedMessage: String?
    
    lazy var provider: web3 = Web3.InfuraRinkebyWeb3()
    
    private init() {}
    
    func storePrivateKey(_ privateKey: String) {
        let formattedKey = privateKey.trimmingCharacters(in: .whitespacesAndNewlines)
        self.privateKey = formattedKey
    }
    
    func storeAccountAddress(_ accountAddress: String) {
        self.accountAddress = accountAddress
    }
    
    func storeKeystore() throws {
        do {
            guard let privateKeyData = self.privateKeyData else { return }
            self.keystore = try EthereumKeystoreV3(privateKey: privateKeyData)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getAccountAndBalance() throws -> Wallet {
        guard self.privateKey != nil else { fatalError("Need to store private key first.") }
        
        do {
            guard let accountAddress = self.keystore?.getAddress() else { throw EthereumError.noAccountAddressFound }
            guard let walletBalance = try? provider.eth.getBalance(address: accountAddress) else { throw EthereumError.noBalanceAvailable }
            
            storeAccountAddress(accountAddress.address)
            
            let wallet = Wallet(accountAddress: accountAddress.address, balance: walletBalance.formattedEthereumBalance)
            
            return wallet
        } catch {
            throw EthereumError.genericError(error.localizedDescription)
        }
    }
    
    func signMessage(_ message: String) -> Data? {
        guard let keystore = self.keystore else { return nil }
        
        let keystoreManager = KeystoreManager([keystore])
        provider.addKeystoreManager(keystoreManager)
        
        guard let addresses = keystoreManager.addresses else { return nil }
        do {
            guard let messageData = message.data(using: .utf8) else { return nil }
            
            let signedData = try provider.personal.signPersonalMessage(message: messageData, from: addresses[0])
            let signedBase64Data = signedData.base64EncodedData()
            
            signedMessage = message
            
            return signedBase64Data
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func validateQr(_ qrStringValue: String, verificationMessage: String, completion: @escaping (Swift.Result<String, EthereumError>) -> Void) {
        guard let verificationMessageData = verificationMessage.data(using: .utf8) else { return }
        
        if let signature = Data(base64Encoded: qrStringValue),
            let unmarshalledSignature = SECP256K1.unmarshalSignature(signatureData: signature) {
            
            let signer = try? provider.personal.ecrecover(personalMessage: verificationMessageData,
                                                          signature: signature)
            
            if signer?.address == accountAddress {
                completion(.success("Signature is valid."))
            } else {
                completion(.failure(EthereumError.invalidQrCode(qrStringValue)))
            }
        }
        completion(.failure(EthereumError.cannotValidateQrCode(qrStringValue)))
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

