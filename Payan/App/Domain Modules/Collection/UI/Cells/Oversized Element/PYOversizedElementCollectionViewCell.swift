//
//  PYOversizedElementCollectionViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 6/05/22.
//

import Kingfisher
import SkeletonView
import UIKit

class PYOversizedElementCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subBackgroundView: UIView!
    
    static let reuseIdentifier = "PYOversizedElementCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubiews()
    }

    private func setupSubiews() {
        isSkeletonable = true
        imageView.contentMode = .scaleAspectFill
        subBackgroundView.backgroundColor = .black.withAlphaComponent(0.35)
        titleLabel.textAlignment = .center
        titleLabel.font = AppStyle.Font.get(.medium, size: .subtitle)
        titleLabel.textColor = AppStyle.Color.F2
        titleLabel.text = ""
    }
    
    func setImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        imageView.kf.setImage(with: url)
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
