//
//  TextFieldForm.swift
//  Payan
//
//  Created by juandahurt on 19/09/21.
//

import UIKit

class TextFieldForm: UITextField {
    let padding = UIEdgeInsets(top: 0, left: UIConstants.textFieldFormPadding, bottom: 0, right: UIConstants.textFieldFormPadding)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setup()
    }
    
    private func setup() {
        font = Font.get(.regular, size: .body)
        textColor = .black
        backgroundColor = Color.textFieldForm
        self.attributedPlaceholder = NSAttributedString(string: "placeholder", attributes: [NSAttributedString.Key.foregroundColor: Color.primary.withAlphaComponent(0.4)])
    }
}
