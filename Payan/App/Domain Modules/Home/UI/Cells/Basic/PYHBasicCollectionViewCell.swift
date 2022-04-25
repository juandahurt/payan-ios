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
        isSkeletonable = true
        layer.cornerRadius = 5
        subBackgroundView.backgroundColor = .black.withAlphaComponent(0.35)
        imageView.contentMode = .scaleAspectFill
        titleLabel.textColor = AppStyle.Color.F2
        titleLabel.font = AppStyle.Font.get(.medium, size: .footer)
        imageView.kf.indicatorType = .activity
        titleLabel.text = ""
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        imageView.kf.setImage(with: url)
    }
}
