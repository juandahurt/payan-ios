//
//  PYElementImageCollectionViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 7/05/22.
//

import Kingfisher
import SkeletonView
import UIKit

class PYElementImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    static let reuseIdentifier = "PYElementImageCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
    }
    
    private func setupSubviews() {
        isSkeletonable = true
        backgroundColor = AppStyle.Color.F1
    }
    
    func setImage(_ url: String) {
        guard let url = URL(string: url) else { return }
        imageView.kf.setImage(with: url)
    }
}
