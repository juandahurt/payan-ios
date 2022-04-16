//
//  PYHBasicCollectionViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 16/04/22.
//

import Kingfisher
import UIKit

class PYHBasicCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var subBackgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let reuseIdentifier = "PYHBasicCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 5
        subBackgroundView.backgroundColor = .black.withAlphaComponent(0.2)
        imageView.contentMode = .scaleAspectFill
        titleLabel.textColor = AppStyle.Color.F2
        titleLabel.font = AppStyle.Font.get(.medium, size: .footer)
        imageView.kf.indicatorType = .activity
        
        imageView.kf.setImage(with: URL(string: "https://upload.wikimedia.org/wikipedia/commons/7/79/Josehilariolopez1.png")!)
        titleLabel.text = "Nombre del prócer"
    }
}
