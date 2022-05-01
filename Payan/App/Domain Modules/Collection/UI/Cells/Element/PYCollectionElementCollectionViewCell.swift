//
//  PYCollectionElementCollectionViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 15/04/22.
//

import Kingfisher
import UIKit

class PYCollectionElementCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var subBackgroundView: UIView!
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let reuseIdentifier = "PYCollectionElementCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    
    private func setupView() {
        isSkeletonable = true
        subBackgroundView.backgroundColor = .black.withAlphaComponent(0.35)
        elementImageView.contentMode = .scaleAspectFill
        titleLabel.font = AppStyle.Font.get(.medium, size: .footer)
        titleLabel.textColor = AppStyle.Color.F2
        titleLabel.text = ""
    }
    
    func setImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        elementImageView.kf.setImage(with: url)
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
