//
//  PYCItemCollectionViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 15/04/22.
//

import Kingfisher
import UIKit

class PYCItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var subBackgroundView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    static let reuseIdentifier = "PYCItemCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    
    private func setupView() {
        subBackgroundView.backgroundColor = .black.withAlphaComponent(0.2)
        itemImageView.contentMode = .scaleAspectFill
        itemNameLabel.font = AppStyle.Font.get(.medium, size: .footer)
        itemNameLabel.textColor = AppStyle.Color.F2
        
        itemImageView.kf.setImage(with: URL(string: "https://payan-dev-images.s3.us-east-2.amazonaws.com/san-jose.jpg")!)
        itemNameLabel.text = "Nombre del museo"
    }
}
