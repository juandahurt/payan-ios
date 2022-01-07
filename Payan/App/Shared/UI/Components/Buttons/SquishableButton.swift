//
//  BaseButton.swift
//  Payan
//
//  Created by juandahurt on 3/11/21.
//

import Foundation
import UIKit

class SquishableButton: UIButton {
    // MARK: - Public
    var background: UIColor? {
        nil
    }
    public var textColor: UIColor? {
        nil
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        setup()
    }
    
    private func setup() {
        setTitleColor(textColor, for: .normal)
        layer.cornerRadius = AppStyle.UIConstants.buttonCornerRadius
        backgroundColor = background
        titleLabel?.font = AppStyle.Font.get(.semiBold, size: .subtitle)
        
        self.addTarget(self, action: #selector(onPressed(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(onRelease(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(onRelease(_:)), for: .touchUpOutside)
    }
    
    @objc
    func onPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc
    func onRelease(_ sender: Any) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}
