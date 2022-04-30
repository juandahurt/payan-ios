//
//  PYCViewController.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import UIKit

class PYCViewController: PYBaseViewController, PYCViewLogic {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var typeId: String = ""
    var interactor: PYCBusinessLogic
    private var collection: PYCollection?
    
    init(interactor: PYCBusinessLogic) {
        self.interactor = interactor
        
        let nibName = String(describing: Self.self)
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        interactor.getPlaces(withTypeId: typeId)
    }
    
    private func setupSubviews() {
        view.backgroundColor = AppStyle.Color.F2
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        registerCells()
        collectionView.backgroundColor = AppStyle.Color.F2
        let bottomSafeAreaHeight = view.safeAreaInsets.bottom
        collectionView.contentInset = .init(top: 0, left: 0, bottom: bottomSafeAreaHeight, right: 0)
        collectionView.delegate = self
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
    
    func renderCollection(_ collection: PYCollection) {
        self.collection = collection
        collectionView.reloadData()
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
//            router.showPlace()
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
            title = collection?.title ?? ""
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            title = ""
        }
    }
}

extension PYCViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYCTitleCollectionViewCell.reuseIdentifier, for: indexPath) as! PYCTitleCollectionViewCell
            cell.setTitle(collection?.title ?? "")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYCItemCollectionViewCell.reuseIdentifier, for: indexPath) as! PYCItemCollectionViewCell
            cell.setImage(collection?.elements[indexPath.row].image ?? "")
            cell.setTitle(collection?.elements[indexPath.row].title ?? "")
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
            return collection?.elements.count ?? 0
        }
    }
}
