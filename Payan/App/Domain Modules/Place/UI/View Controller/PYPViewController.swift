//
//  PYPViewController.swift
//  Payan
//
//  Created by Juan Hurtado on 10/04/22.
//

import UIKit

class PYPViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
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
        view.backgroundColor = AppStyle.Color.F2
    }
    
    private func setupTableView() {
        
    }
}
