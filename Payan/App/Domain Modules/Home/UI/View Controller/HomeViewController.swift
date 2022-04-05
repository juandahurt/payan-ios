//
//  HomeViewController.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet private weak var hiLabel: UILabel!
    
    init() {
        let nibName = String(describing: Self.self)
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.backgroundColor = AppStyle.Color.N8
        hiLabel.font = AppStyle.Font.get(.semiBold, size: .title)
        hiLabel.text = "Buenos días"
    }
}
