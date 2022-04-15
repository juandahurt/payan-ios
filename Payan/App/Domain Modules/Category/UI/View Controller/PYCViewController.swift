//
//  PYCViewController.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import UIKit

class PYCViewController: PYBaseViewController, PYCViewLogic {
    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet private weak var tableView: UITableView!
    
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
//        navigationBarIsHidden = false
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        title = "Puentes"
        
        view.backgroundColor = AppStyle.Color.F2
        
        setupTableView()
    }
    
    private func setupTableView() {
        registerCells()
        
//        let nibName = String(describing: PYCTableViewCell.self)
//        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: PYCTableViewCell.reuseIdentifier)
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.separatorColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerCells() {
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        let titleNibName = String(describing: PYCTitleCollectionViewCell.self)
        collectionView.register(UINib(nibName: titleNibName, bundle: nil), forCellWithReuseIdentifier: PYCTitleCollectionViewCell.reuseIdentifier)
        
        let itemNibName = String(describing: PYCItemCollectionViewCell.self)
        collectionView.register(UINib(nibName: itemNibName, bundle: nil), forCellWithReuseIdentifier: PYCItemCollectionViewCell.reuseIdentifier)
    }
    
    func showLoading() {
        super.showLoading()
    }
    
    func updatePlacesTable() {
        
//        tableView.reloadData()
    }
}

extension PYCViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        if indexPath.section == 0 {
            return CGSize(width: screenWidth, height: 100)
        }
        return CGSize(width: (screenWidth / 3) - CGFloat(3), height: (screenWidth / 3) - CGFloat(3))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            router.showPlace()
        }
    }
}

extension PYCViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYCTitleCollectionViewCell.reuseIdentifier, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYCItemCollectionViewCell.reuseIdentifier, for: indexPath)
            return cell
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//            cell.backgroundColor = .gray
//            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 20
        }
    }
}
//extension PYCViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        interactor.places.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: PYCTableViewCell.reuseIdentifier, for: indexPath) as! PYCTableViewCell
//
//        let bgView = UIView()
//        bgView.backgroundColor = .clear
//        cell.selectedBackgroundView = bgView
//        if indexPath.row == interactor.places.count - 1 {
//            cell.hideDivider()
//        }
//        #warning("TODO: set cell's data")
//
//        return cell
//    }
//}
//
//extension PYCViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        router.showPlace()
//    }
//}
