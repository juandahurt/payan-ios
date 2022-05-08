//
//  PYCollectionViewController.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import SkeletonView
import UIKit

class PYCollectionViewController: PYBaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var typeId: String = ""
    var interactor: PYCollectionBusinessLogic
    private var collection: PYCollection?
    
    init(interactor: PYCollectionBusinessLogic) {
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
        interactor.getCollection(withTypeId: typeId)
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
        let titleNibName = String(describing: PYCollectionTitleCollectionViewCell.self)
        collectionView.register(UINib(nibName: titleNibName, bundle: nil), forCellWithReuseIdentifier: PYCollectionTitleCollectionViewCell.reuseIdentifier)
        
        let elementNibName = String(describing: PYCollectionElementCollectionViewCell.self)
        collectionView.register(UINib(nibName: elementNibName, bundle: nil), forCellWithReuseIdentifier: PYCollectionElementCollectionViewCell.reuseIdentifier)
        
        let oversizedNibName = String(describing: PYOversizedElementCollectionViewCell.self)
        collectionView.register(UINib(nibName: oversizedNibName, bundle: nil), forCellWithReuseIdentifier: PYOversizedElementCollectionViewCell.reuseIdentifier)
    }
}

extension PYCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        if indexPath.section == 0 {
            return CGSize(width: screenWidth, height: 100)
        }
        guard let collection = collection else { return .zero }
        return PYCollectionCellSizeFactory.createSize(for: collection.layout)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let collection = collection else { return }
            guard let url = URL(string: collection.elements[indexPath.row].deeplink) else { return }
            PYRoutingManager.shared.open(url: url)
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

extension PYCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYCollectionTitleCollectionViewCell.reuseIdentifier, for: indexPath) as! PYCollectionTitleCollectionViewCell
            cell.setTitle(collection?.title ?? "")
            return cell
        } else {
            let cell = PYCollectionCellFactory.createCell(for: collection!.layout, element: collection!.elements[indexPath.row], inside: collectionView, indexPath: indexPath)
            if collection is PYLoadingCollection {
                cell.showAnimatedSkeleton()
            } else {
                cell.stopSkeletonAnimation()
                cell.hideSkeleton()
            }
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


extension PYCollectionViewController: PYCollectionViewLogic {
    func renderCollection(_ collection: PYCollection) {
        self.collection = collection
        collectionView.reloadData()
    }
    
    func showGenericError() {
        showGenericError { [weak self] in
            guard let self = self else { return }
            self.interactor.getCollection(withTypeId: self.typeId)
        }
    }
}
