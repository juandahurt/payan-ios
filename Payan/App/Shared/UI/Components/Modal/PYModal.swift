//
//  PYModal.swift
//  Payan
//
//  Created by Juan Hurtado on 3/04/22.
//

import Foundation
import UIKit


class PYModal: UIView {
    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var verticalConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var dismissButton: UIButton!
    
    private let backgroundAnimationDuration = 0.3
    private let containerAnimationDuration = 0.4
    
    init(frame: CGRect, config: PYModalConfig) {
        super.init(frame: frame)
        
        setupFromNib()
        setupView(using: config)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupFromNib()
        setupView()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        presentModal()
    }
    
    private func presentModal() {
        showBackground()
    }
    
    private func showBackground() {
        UIView.animate(withDuration: backgroundAnimationDuration, delay: 0, options: [.curveEaseIn], animations: { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = .black.withAlphaComponent(0.75)
        }) { [weak self] a in
            guard let self = self else { return }
            self.showContainer()
        }
    }
    
    private func showContainer() {
        UIView.animate(withDuration: containerAnimationDuration, delay: 0, options: [.curveEaseOut]) { [weak self] in
            guard let self = self else { return }
            self.verticalConstraint.constant = 0
            self.layoutIfNeeded()
        }
    }
    
    private func setupView(using config: PYModalConfig) {
        setupCommonUI()
        titleLabel.text = config.title
        contentLabel.text = config.content
        heightConstraint.constant = config.height
        dismissButton.isHidden = !config.isDismissable
    }
    
    private func setupView() {
        setupCommonUI()
    }
    
    private func setupCommonUI() {
        container.layer.masksToBounds = true
        container.layer.cornerRadius = 8
        container.backgroundColor = .white
        titleLabel.textColor = .black.withAlphaComponent(0.9)
        titleLabel.font = AppStyle.Font.get(.medium, size: .title)
        contentLabel.textColor = .black.withAlphaComponent(0.9)
        contentLabel.font = AppStyle.Font.get(.regular, size: .subtitle)
        backgroundColor = .clear
        verticalConstraint.constant = UIScreen.main.bounds.height
    }
}
