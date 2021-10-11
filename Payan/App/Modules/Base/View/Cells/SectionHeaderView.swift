//
//  SectionHeaderView.swift
//  Payan
//
//  Created by juandahurt on 10/10/21.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    private let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        Console.log("xib/storyboard is not supported", level: .error)
        fatalError()
    }
    
    private func setupLayout() {
        textLabel.textColor = .black
        textLabel.font = Font.get(.semiBold, size: .title)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func setup(text: String?) {
        textLabel.text = text
    }
}
