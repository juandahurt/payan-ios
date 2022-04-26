//
//  PYButton.swift
//  Payan
//
//  Created by Juan Hurtado on 4/04/22.
//

import Foundation
import UIKit


class PYButton: UIButton {
    var type: PYButtonType = .loud {
        didSet {
            updateColors()
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 4
        titleLabel?.font = AppStyle.Font.get(.semiBold, size: .subtitle)
        contentEdgeInsets = .init(top: 8, left: 12, bottom: 8, right: 12)
        updateColors()
        
        self.addTarget(self, action: #selector(onPressed(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(onRelease(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(onRelease(_:)), for: .touchUpOutside)
    }
    
    @objc
    func onPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = self.getPressedColor()
        }
    }
    
    @objc
    func onRelease(_ sender: Any) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = self.getBackgroundColor()
        }
    }
    
    private func updateColors() {
        backgroundColor = getBackgroundColor()
        setTitleColor(getTitleColor(), for: .normal)
    }
    
    private func getBackgroundColor() -> UIColor {
        if type == .loud {
            return AppStyle.Color.G2
        } else if type == .quiet {
            return AppStyle.Color.G8
        }
        return .gray
    }
    
    private func getTitleColor() -> UIColor {
        // TODO: Support all the types
        if type == .loud {
            return .white
        } else if type == .quiet {
            return AppStyle.Color.G2
        }
        return .black
    }
    
    private func getPressedColor() -> UIColor {
        if type == .loud {
            return AppStyle.Color.G1
        } else if type == .quiet {
            return AppStyle.Color.G7
        }
        return .black
    }
}


enum PYButtonType {
    case loud
    case quiet
    case transparent
}
