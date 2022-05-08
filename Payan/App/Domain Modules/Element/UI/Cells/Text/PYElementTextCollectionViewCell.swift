//
//  PYElementTextCollectionViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 8/05/22.
//

import UIKit

class PYElementTextCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    
    static let reuseIdentifier = "PYElementTextCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
    }
    
    private func setupSubviews() {
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.font = AppStyle.Font.get(.regular, size: .body)
        contentLabel.textColor = AppStyle.Color.N1
        contentLabel.textAlignment = .justified
    }
    
    func setContent(_ content: String) {
        contentLabel.text = content
    }
}
