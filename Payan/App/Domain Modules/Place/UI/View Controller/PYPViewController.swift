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
        setupTableView()
    }
    
    private func setupSubviews() {
        view.backgroundColor = AppStyle.Color.F2
    }
    
    private func setupTableView() {
        let headerNibName = String(describing: PYPHeaderTableViewCell.self)
        tableView.register(UINib(nibName: headerNibName, bundle: nil), forCellReuseIdentifier: PYPHeaderTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
    }
}


extension PYPViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PYPHeaderTableViewCell.reuseIdentifier, for: indexPath)
        
        return cell
    }
}
