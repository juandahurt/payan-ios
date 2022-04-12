//
//  PYCViewController.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import UIKit

class PYCViewController: PYBaseViewController, PYCViewLogic {
    @IBOutlet private weak var tableView: UITableView!
    
    var interactor: PYCBusinessLogic
    var router: PYCRoutingLogic
    
    init(interactor: PYCBusinessLogic, router: PYCRoutingLogic) {
        self.interactor = interactor
        self.router = router
        
        let nibName = String(describing: Self.self)
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
        interactor.getPlaces()
    }
    
    private func setupSubviews() {
        navigationBarIsHidden = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        title = "Puentes"
        
        view.backgroundColor = AppStyle.Color.F2
        
        setupTableView()
    }
    
    private func setupTableView() {
        let nibName = String(describing: PYCTableViewCell.self)
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: PYCTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
    }
    
    func showLoading() {
        super.showLoading(hidesSubviews: false)
    }
    
    func updatePlacesTable() {
        tableView.reloadData()
    }
}


extension PYCViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PYCTableViewCell.reuseIdentifier, for: indexPath) as! PYCTableViewCell
        
        let bgView = UIView()
        bgView.backgroundColor = .clear
        cell.selectedBackgroundView = bgView
        if indexPath.row == interactor.places.count - 1 {
            cell.hideDivider()
        }
        #warning("TODO: set cell's data")
        
        return cell
    }
}

extension PYCViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.showPlace()
    }
}
