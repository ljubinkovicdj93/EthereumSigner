//
//  EnhancedTextField.swift
//  EthereumSigner
//
//  Created by Djordje Ljubinkovic on 2/16/20.
//  Copyright © 2020 Djordje Ljubinkovic. All rights reserved.
//

import UIKit

enum ValidationState: Equatable {
    case none
    case valid
    case invalid(_ reason: String)
}

enum MaximumCharactersAllowed: Equatable {
    case unlimited
    case limited(Int)
}

protocol TextFieldable: UITextFieldDelegate {
    var textField: UITextField? { get set }
    
    func setup(_ textField: UITextField)
    var onTextDidChange: ((String) -> Void)? { get set }
}

protocol ValidatableTextField: TextFieldable {
    var textValidator: TextValidator? { get set }
    var maximumCharactersAllowed: MaximumCharactersAllowed! { get }
    init(maximumCharactersAllowed: MaximumCharactersAllowed, textValidator: TextValidator?, onTextDidChangeCompletion: @escaping (String) -> Void)
}

class ValidationConfiguration: NSObject, ValidatableTextField {
    
    var textField: UITextField?
    var maximumCharactersAllowed: MaximumCharactersAllowed!
    var textValidator: TextValidator?
    var onTextDidChange: ((String) -> Void)?
    
    var currentText: String {
        get { return textField?.text ?? . empty }
        set { textField?.text = newValue }
    }
    
    var currentValidationState: ValidationState {
        return textValidator?.onValidate(currentText) ?? .none
    }
    
    required init(maximumCharactersAllowed: MaximumCharactersAllowed = .unlimited, textValidator: TextValidator? = nil, onTextDidChangeCompletion: @escaping (String) -> Void) {
        self.maximumCharactersAllowed = maximumCharactersAllowed
        self.textValidator = textValidator
        self.onTextDidChange = onTextDidChangeCompletion
    }
    
    func setup(_ textField: UITextField) {
        self.textField = textField
        self.textField?.addTarget(self, action: #selector(textUpdated), for: .editingChanged)
        self.textField?.delegate = self
    }
    
    func updateMaximumCharactersLimit(_ maximumCharactersAllowed: MaximumCharactersAllowed) {
        self.maximumCharactersAllowed = maximumCharactersAllowed
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard case .limited(let limit) = maximumCharactersAllowed else {
            return true
        }
        if string == .empty { return true } // return true if user is deleting characters
        if string == .whitespace { return false }
        return currentText.count < limit
    }
    
    @objc private func textUpdated() {
        onTextDidChange?(currentText)
    }
}

struct TextValidator {
    private struct Constants {
        struct Ethereum {
            static let AllZeroCharacters: String = Array(repeating: "0", count: Constants.Ethereum.MaximumCharactersAllowed.PrivateKey).joined(separator: .empty)
            
            struct MaximumCharactersAllowed {
                static let PrivateKey: Int = 64
            }
        }
    }
    
    let onValidate: (String) -> ValidationState
    
    static let EthereumPrivateKeyValidator = TextValidator { text in
        guard !text.isEmpty else { return .none }
        
        let formattedText = text.stripHexCode()
        
        if formattedText.count == Constants.Ethereum.MaximumCharactersAllowed.PrivateKey && formattedText.isAlphanumeric && formattedText != Constants.Ethereum.AllZeroCharacters {
            return .valid
        } else {
            return .invalid("Invalid private key. Enter at least 64 alphanumeric letters, or 66 if the first two are `0x`")
        }
    }
}
