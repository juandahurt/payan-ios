//
//  PYCTableViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Kingfisher
import UIKit

class PYCTableViewCell: UITableViewCell {
    @IBOutlet private weak var placeImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var dividerView: UIView!
    
    static let reuseIdentifier = "PYCTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        #warning("TODO: remove dummy data")
        backgroundColor = AppStyle.Color.F2
        titleLabel.font = AppStyle.Font.get(.medium, size: .subtitle)
        titleLabel.textColor = AppStyle.Color.N1
        titleLabel.text = "El morro de Tulcán"
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        subtitleLabel.font = AppStyle.Font.get(.regular, size: .footer)
        subtitleLabel.textColor = AppStyle.Color.N4
        subtitleLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
        
        placeImageView.kf.indicatorType = .activity
        placeImageView.kf.setImage(with: URL(string: "https://payan-dev-images.s3.us-east-2.amazonaws.com/san-jose.jpg")!)
        placeImageView.layer.cornerRadius = 5
        
        dividerView.backgroundColor = AppStyle.Color.N8
    }
    
    func hideDivider() {
        dividerView.isHidden = true
    }
}
