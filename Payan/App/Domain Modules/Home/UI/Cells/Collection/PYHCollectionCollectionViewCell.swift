//
//  PYHCollectionCollectionViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 16/04/22.
//

import Kingfisher
import UIKit

class PYHCollectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var subBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    static let reuseIdentifier = "PYHCollectionCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        layer.cornerRadius = 5
        titleLabel.font = AppStyle.Font.get(.medium, size: .body)
        titleLabel.textColor = AppStyle.Color.F2
        subtitleLabel.font = AppStyle.Font.get(.regular, size: .footer)
        subtitleLabel.textColor = AppStyle.Color.F2
        subBackgroundView.backgroundColor = .black.withAlphaComponent(0.35)
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        
        titleLabel.text = "Museos"
        subtitleLabel.text = "12 lugares"
        imageView.kf.setImage(with: URL(string: "https://payan-dev-images.s3.us-east-2.amazonaws.com/san-jose.jpg")!)
    }
}
