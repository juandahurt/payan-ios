//
//  PYHPlaceCategoriesView.swift
//  Payan
//
//  Created by Juan Hurtado on 4/04/22.
//

import Foundation
import UIKit


class PYHPlaceCategoriesView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFromNib()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupFromNib()
        setupView()
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = AppStyle.Font.get(.medium, size: .body)
        titleLabel.text = "Puedes buscar por categoría"
        titleLabel.textColor = AppStyle.Color.N1
    }
}
