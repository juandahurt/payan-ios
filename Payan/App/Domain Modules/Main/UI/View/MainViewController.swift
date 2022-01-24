//
//  MainViewController.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import UIKit

class MainViewController: TabBarViewController {
    init() {
        super.init(nibName: String(describing: MainViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
