//
//  PYPViewController.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import UIKit

class PYPViewController: PYBaseViewController {
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
        showLoading(hidesSubviews: false)
    }
    
    private func setupSubviews() {
        navigationBarIsHidden = false
        title = "Puentes"
        view.backgroundColor = AppStyle.Color.F2
    }
}
