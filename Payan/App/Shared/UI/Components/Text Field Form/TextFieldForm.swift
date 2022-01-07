//
//  TextFieldForm.swift
//  Payan
//
//  Created by juandahurt on 19/09/21.
//

import UIKit

class TextFieldForm: UITextField {
    let padding = UIEdgeInsets(top: 0, left: AppStyle.UIConstants.textFieldFormPadding, bottom: 0, right: AppStyle.UIConstants.textFieldFormPadding)

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
        borderStyle = .none
        layer.cornerRadius = AppStyle.UIConstants.textFieldCornerRadius
        autocorrectionType = .no
        font = AppStyle.Font.get(.regular, size: .body)
        textColor = .black
        backgroundColor = AppStyle.Color.textFieldForm
        attributedPlaceholder = NSAttributedString(string: "placeholder", attributes: [NSAttributedString.Key.foregroundColor: AppStyle.Color.primary.withAlphaComponent(0.4)])
    }
}
