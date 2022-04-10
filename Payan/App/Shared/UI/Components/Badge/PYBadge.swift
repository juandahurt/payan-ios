//
//  PYBadge.swift
//  Payan
//
//  Created by Juan Hurtado on 10/04/22.
//

import UIKit

class PYBadge: UIView {
    @IBOutlet private var contentView: UIView!
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
        contentView.backgroundColor = AppStyle.Color.B1
        contentView.layer.cornerRadius = 2
        
        titleLabel.text = "MUSEO"
        titleLabel.font = AppStyle.Font.get(.medium, size: .footer)
    }
}
