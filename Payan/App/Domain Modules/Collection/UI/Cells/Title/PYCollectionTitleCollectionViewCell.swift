//
//  PYCollectionTitleCollectionViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 14/04/22.
//

import UIKit

class PYCollectionTitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    static let reuseIdentifier = "PYCollectionTitleCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        titleLabel.font = AppStyle.Font.get(.regular, size: .header)
        titleLabel.textColor = AppStyle.Color.N1
        titleLabel.text = ""
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
