//
//  HeaderView.swift
//  Payan
//
//  Created by juandahurt on 26/12/21.
//

import UIKit

class HeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    private func setup() {
        titleLabel.font = Font.get(.semiBold, size: .title)
    }
    
    func configure(title: String, image: UIImage) {
        titleLabel.text = title
        imageView.image = image
    }
}
