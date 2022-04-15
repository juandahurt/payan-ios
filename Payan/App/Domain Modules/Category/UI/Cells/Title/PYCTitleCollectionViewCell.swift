//
//  PYCTitleCollectionViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 14/04/22.
//

import UIKit

class PYCTitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    static let reuseIdentifier = "PYCTitleCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        titleLabel.font = AppStyle.Font.get(.regular, size: .header)
        titleLabel.textColor = AppStyle.Color.N1
        titleLabel.text = "Museos"
    }
}
