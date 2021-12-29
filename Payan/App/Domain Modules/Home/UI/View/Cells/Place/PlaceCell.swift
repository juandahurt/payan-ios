//
//  PlaceCell.swift
//  Payan
//
//  Created by juandahurt on 5/10/21.
//

import UIKit
import Kingfisher

class PlaceCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        imageView.layer.cornerRadius = 10
        
        titleLabel.font = AppStyle.Font.get(.regular, size: .body)
        titleLabel.textColor = .black
        
        subtitleLabel.font = AppStyle.Font.get(.regular, size: .body)
        subtitleLabel.textColor = UIColor.black.withAlphaComponent(0.4)
    }

    func setup(place: Place) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            let placeStr: String
            switch place.type {
            case .museum:
                placeStr = "Museo"
            case .park:
                placeStr = "Parque"
            case .bridge:
                placeStr = "Puente"
            case .church:
                placeStr = "Iglesia"
            }
            self.titleLabel.text = place.name
            self.subtitleLabel.text = placeStr
            
            self.imageView.contentMode = .scaleAspectFill
            if let url = URL(string: place.imageUrl) {
                self.imageView.kf.indicatorType = .activity
                self.imageView.kf.setImage(with: url)
            }
        }
        
    }
    
    func showSkeletonAnimation() {
        imageView.isSkeletonable = true
        imageView.skeletonCornerRadius = 10
        
        titleLabel.isSkeletonable = true
        titleLabel.linesCornerRadius = 5
        titleLabel.lastLineFillPercent = Int.random(in: 0...100)
        
        subtitleLabel.isSkeletonable = true
        subtitleLabel.linesCornerRadius = 5
        subtitleLabel.lastLineFillPercent = Int.random(in: 0...100)
        
        contentView.isSkeletonable = true
        
        showAnimatedSkeleton()
    }
}
