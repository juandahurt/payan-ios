//
//  PYPImageTableViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 10/04/22.
//

import UIKit
import Kingfisher

class PYPImageTableViewCell: UITableViewCell {
    @IBOutlet weak var placeImageView: UIImageView!
    
    static let reuseIdentifier = "PYPImageTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        backgroundColor = .clear
        
        placeImageView.contentMode = .scaleAspectFill
        placeImageView.kf.indicatorType = .activity
        placeImageView.kf.setImage(with: URL(string: "https://payan-dev-images.s3.us-east-2.amazonaws.com/san-jose.jpg")!)
    }
}
