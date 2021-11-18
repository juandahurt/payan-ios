//
//  PlaceTitleViewController.swift
//  Payan
//
//  Created by juandahurt on 17/11/21.
//

import UIKit

class PlaceTitleViewController: UIViewController {
    @IBOutlet weak var placeImageView: UIImageView! {
        didSet {
            placeImageView.contentMode = .scaleAspectFill
            if let url = URL(string: placeDetails.imageUrl) {
                placeImageView.kf.setImage(with: url)
            }
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = placeDetails.name
            titleLabel.font = Font.get(.semiBold, size: .header)
            titleLabel.textColor = .white
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = .byWordWrapping
        }
    }
    
    private let placeDetails: PlaceDetails
    
    init(placeDetails: PlaceDetails) {
        self.placeDetails = placeDetails
        super.init(nibName: String(describing: PlaceTitleViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Console.log("init(coder:) has not been implemented", level: .error)
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGradient()
    }

    private func addGradient() {
        let gradient = CAGradientLayer()

        gradient.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.cgColor]
        gradient.frame = view.frame

        placeImageView.layer.addSublayer(gradient)
    }
}
