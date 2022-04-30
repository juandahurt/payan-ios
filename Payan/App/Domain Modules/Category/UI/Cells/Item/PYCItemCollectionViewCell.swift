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
        subBackgroundView.backgroundColor = .black.withAlphaComponent(0.35)
        itemImageView.contentMode = .scaleAspectFill
        itemNameLabel.font = AppStyle.Font.get(.medium, size: .footer)
        itemNameLabel.textColor = AppStyle.Color.F2
        itemNameLabel.text = ""
    }
    
    func setImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        itemImageView.kf.setImage(with: url)
    }
    
    func setTitle(_ title: String) {
        itemNameLabel.text = title
    }
}
