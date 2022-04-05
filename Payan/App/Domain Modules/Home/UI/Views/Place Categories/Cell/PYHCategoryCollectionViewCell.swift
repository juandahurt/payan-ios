//
//  PYHCategoryCollectionViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 4/04/22.
//

import UIKit

class PYHCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageContainer: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        titleLabel.text = "Iglesias"
        titleLabel.textColor = AppStyle.Color.N1
        titleLabel.font = AppStyle.Font.get(.regular, size: .footer)
        
        imageContainer.layer.cornerRadius = imageContainer.frame.width / 2
        imageContainer.layer.borderColor = AppStyle.Color.N8.cgColor
        imageContainer.layer.borderWidth = 1
    }
}
