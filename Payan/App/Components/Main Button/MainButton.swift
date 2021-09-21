//
//  MainButton.swift
//  Payan
//
//  Created by juandahurt on 18/09/21.
//

import UIKit

final class MainButton: LoadableButton {    
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
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = UIConstants.buttonCornerRadius
        backgroundColor = Color.primary
        titleLabel?.font = Font.get(.semiBold, size: .subtitle)
        self.addTarget(self, action: #selector(onPressed(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(onRelease(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(onRelease(_:)), for: .touchUpOutside)
    }
    
    @objc
    func onPressed(_ sender: Any) {
        Console.log("button was pressed", level: .event)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }
    }
    
    @objc
    func onRelease(_ sender: Any) {
        Console.log("button was released", level: .event)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}
