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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var verticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    private let backgroundAnimationDuration = 0.3
    private let containerAnimationDuration = 0.4
    private let defaultHeight = 250.0
    
    init(frame: CGRect, height: Double) {
        super.init(frame: frame)
        
        setupFromNib()
        setupView(height: height)
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
    
    private func setupView(height: Double) {
        setupCommonUI()
        heightConstraint.constant = height
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
        
        titleLabel.text = "¡Hay una nueva actualización disponible!"
        contentLabel.text = "Te recomendamos actualizar la app para que puedas disfrutar de la mejor experiencia."
    }
}
