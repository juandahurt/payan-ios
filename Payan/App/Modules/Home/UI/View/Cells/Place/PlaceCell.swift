//
//  PlaceCell.swift
//  Payan
//
//  Created by juandahurt on 5/10/21.
//

import UIKit

class PlaceCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
