//
//  PYHCityView.swift
//  Payan
//
//  Created by Juan Hurtado on 11/04/22.
//

import Foundation
import UIKit


class PYHCityView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var cityImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupShadow()
    }
    
    private func setupView() {
        titleLabel.textColor = AppStyle.Color.N1
        titleLabel.font = AppStyle.Font.get(.medium, size: .body)
        cityImageView.backgroundColor = .clear
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = AppStyle.Font.get(.regular, size: .footer)
        descriptionLabel.textColor = AppStyle.Color.N4
        
        contentView.backgroundColor = AppStyle.Color.F2
        contentView.layer.cornerRadius = 5
        
        #warning("TODO: add data source!")
        descriptionLabel.text = "Popayán, oficialmente Asunción de Popayán, es un municipio colombiano, capital del departamento del Cauca. Se encuentra localizado en el valle de Pubenza, entre la Cordillera Occidental y Central al suroccidente del país."
        titleLabel.text = "¿Quién es Popayán?"
        cityImageView.image = UIImage(named: "city")
    }
    
    private func setupShadow() {
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        contentView.layer.shadowOffset = .init(width: 0, height: 6)
        contentView.layer.shadowRadius = 16
        contentView.layer.shadowOpacity = 1
    }
}
