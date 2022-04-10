//
//  PYPHeaderTableViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 10/04/22.
//

import UIKit

class PYPHeaderTableViewCell: UITableViewCell {
    @IBOutlet private weak var placeNameLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    static let reuseIdentifier = "PYPHeaderTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        placeNameLabel.font = AppStyle.Font.get(.medium, size: .title)
        placeNameLabel.textColor = AppStyle.Color.N1
        
        subtitleLabel.font = AppStyle.Font.get(.regular, size: .footer)
        subtitleLabel.textColor = AppStyle.Color.N4
        
        backgroundColor = AppStyle.Color.F2
        
        #warning("TODO: remove dummy data")
        placeNameLabel.text = "El morro de Tulcán"
        subtitleLabel.text = "Contruido en 1789"
    }
}
