//
//  PYCViewController.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import UIKit

class PYCViewController: PYBaseViewController {
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
        showLoading(hidesSubviews: false)
    }
    
    private func setupSubviews() {
        navigationBarIsHidden = false
        title = "Puentes"
        
        view.backgroundColor = AppStyle.Color.F2
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "a")
        tableView.dataSource = self
    }
}


extension PYCViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell(style: .subtitle, reuseIdentifier: "a")
    }
}
