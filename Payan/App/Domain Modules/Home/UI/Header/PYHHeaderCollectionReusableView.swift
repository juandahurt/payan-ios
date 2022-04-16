//
//  PYHHeaderCollectionReusableView.swift
//  Payan
//
//  Created by Juan Hurtado on 15/04/22.
//

import UIKit

class PYHHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var secondaryButton: UIButton!
    
    static let reuseIdentifier = "PYHHeaderCollectionReusableView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        titleLabel.font = AppStyle.Font.get(.medium, size: .secondTitle)
        titleLabel.textColor = AppStyle.Color.N1
        subtitleLabel.font = AppStyle.Font.get(.regular, size: .body)
        subtitleLabel.textColor = AppStyle.Color.N4
        secondaryButton.titleLabel?.font = AppStyle.Font.get(.medium, size: .footer)
        secondaryButton.tintColor = AppStyle.Color.B1
        
        titleLabel.text = "Explora lugares"
        subtitleLabel.text = "Adentrate en la ciudad blanca"
        secondaryButton.setTitle("Ver más", for: .normal)
    }
}
