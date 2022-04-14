//
//  PYPDescriptionTableViewCell.swift
//  Payan
//
//  Created by Juan Hurtado on 11/04/22.
//

import UIKit

class PYPDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    static let reuseIdentifier = "PYPDescriptionTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = AppStyle.Font.get(.regular, size: .body)
        descriptionLabel.textColor = AppStyle.Color.N1
        
        sourceLabel.font = AppStyle.Font.get(.regular, size: .footer)
        sourceLabel.textColor = AppStyle.Color.N4
        
        backgroundColor = AppStyle.Color.F2
        
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        sourceLabel.text = "Wikpedia"
    }
}
