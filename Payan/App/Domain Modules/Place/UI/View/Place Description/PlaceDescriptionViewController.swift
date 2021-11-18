//
//  PlaceDescriptionViewController.swift
//  Payan
//
//  Created by juandahurt on 18/11/21.
//

import UIKit

class PlaceDescriptionViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "Descripción"
            titleLabel.font = Font.get(.semiBold, size: .title)
            titleLabel.textColor = .white
        }
    }
    @IBOutlet weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.font = Font.get(.regular, size: .body)
            descriptionTextView.textColor = .white
            descriptionTextView.backgroundColor = .clear
            descriptionTextView.text = placeDetails.description
        }
    }
    @IBOutlet weak var titleTopConstraint: NSLayoutConstraint!
    
    private let placeDetails: PlaceDetails
    
    init(placeDetails: PlaceDetails) {
        self.placeDetails = placeDetails
        
        super.init(nibName: String(describing: PlaceDescriptionViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Console.log("init(coder:) has not been implemented", level: .error)
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupTitleTopConstraint()
    }
    
    private func setupBackground() {
        view.backgroundColor = .black
    }
    
    private func setupTitleTopConstraint() {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top
        
        titleTopConstraint.constant = (topPadding ?? 0) + 20
        view.layoutIfNeeded()
    }
}
