//
//  PYCViewController.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import UIKit

class PYCViewController: PYBaseViewController, PYCViewLogic {
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        view.backgroundColor = AppStyle.Color.F2
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        registerCells()
        collectionView.backgroundColor = AppStyle.Color.F2
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 1
//        layout.minimumInteritemSpacing = 1
//
        let bottomSafeAreaHeight = view.safeAreaInsets.bottom
        collectionView.contentInset = .init(top: 0, left: 0, bottom: bottomSafeAreaHeight, right: 0)
        collectionView.delegate = self
//        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 1
//        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing = 0.5
        collectionView.dataSource = self
    }
    
    private func registerCells() {
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
        return CGSize(width: (screenWidth / 3) - CGFloat(2), height: (screenWidth / 3) - CGFloat(2))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            router.showPlace()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            title = "Museos"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            #warning("TODO: set collection title")
            title = ""
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
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 20
        }
    }
}
