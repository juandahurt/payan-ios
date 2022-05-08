//
//  PYElementTitleCollectionViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 8/05/22.
//

import UIKit

class PYElementTitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    static let reuseIdentifier = "PYElementTitleCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
    }
    
    private func setupSubviews() {
        backgroundColor = AppStyle.Color.F2
        titleLabel.numberOfLines = 0
        titleLabel.font = AppStyle.Font.get(.medium, size: .title)
        titleLabel.textColor = AppStyle.Color.N1
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.font = AppStyle.Font.get(.regular, size: .footer)
        subtitleLabel.textColor = AppStyle.Color.N4
        subtitleLabel.textAlignment = .center
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setSubtitle(_ subtitle: String) {
        subtitleLabel.text = subtitle
    }
}
