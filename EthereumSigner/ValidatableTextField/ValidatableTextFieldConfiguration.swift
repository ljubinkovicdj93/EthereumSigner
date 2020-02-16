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
    var textField: UITextField! { get set }
    
    func setup(_ textField: UITextField)
    var onTextDidChange: ((String) -> Void)? { get set }
}

protocol ValidatableTextField: TextFieldable {
    var maximumCharactersAllowed: MaximumCharactersAllowed! { get }
    init(maximumCharactersAllowed: MaximumCharactersAllowed, onTextDidChangeCompletion: @escaping (String) -> Void)
}

class ValidationConfiguration: NSObject, ValidatableTextField {

    var textField: UITextField!
    var maximumCharactersAllowed: MaximumCharactersAllowed!
    var onTextDidChange: ((String) -> Void)?

    var currentText: String {
        get { return textField.text ?? . empty }
        set { textField.text = newValue }
    }
    
    required init(maximumCharactersAllowed: MaximumCharactersAllowed, onTextDidChangeCompletion: @escaping (String) -> Void) {
        self.maximumCharactersAllowed = maximumCharactersAllowed
        self.onTextDidChange = onTextDidChangeCompletion
    }
    
    func setup(_ textField: UITextField) {
        self.textField = textField
        self.textField.addTarget(self, action: #selector(textUpdated), for: .editingChanged)
        self.textField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         guard case .limited(let limit) = maximumCharactersAllowed else {
             return true
         }
         if string == .empty { return true } // return true if user is deleting characters
         return currentText.count < limit
    }
    
    @objc private func textUpdated() {
        onTextDidChange?(currentText)
    }
}
