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
        registerCells()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
//        tableView.color
    }
    
    private func registerCells() {
        let headerNibName = String(describing: PYPHeaderTableViewCell.self)
        tableView.register(UINib(nibName: headerNibName, bundle: nil), forCellReuseIdentifier: PYPHeaderTableViewCell.reuseIdentifier)
        
        let imageNibName = String(describing: PYPImageTableViewCell.self)
        tableView.register(UINib(nibName: imageNibName, bundle: nil), forCellReuseIdentifier: PYPImageTableViewCell.reuseIdentifier)
    }
}


extension PYPViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: PYPHeaderTableViewCell.reuseIdentifier, for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: PYPImageTableViewCell.reuseIdentifier, for: indexPath)
        }
        
        let bgView = UIView()
        bgView.backgroundColor = .clear
        cell.selectedBackgroundView = bgView
        
        return cell
    }
}


extension PYPViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableView.automaticDimension
        } else {
            return UIScreen.main.bounds.height * 0.45
        }
    }
}
