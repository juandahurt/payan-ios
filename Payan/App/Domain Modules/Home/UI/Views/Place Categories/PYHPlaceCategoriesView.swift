//
//  PYHPlaceCategoriesView.swift
//  Payan
//
//  Created by Juan Hurtado on 4/04/22.
//

import Foundation
import UIKit


class PYHPlaceCategoriesView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    weak var dataSource: PYHPlaceCategoriesViewDataSource? {
        didSet {
            numberOfCategories = dataSource?.placesCategoriesView(numberOfCategoriesIn: self) ?? 0
            collectionView.reloadData()
        }
    }
    
    private var numberOfCategories = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFromNib()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupFromNib()
        setupView()
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = AppStyle.Font.get(.medium, size: .body)
        titleLabel.text = "Puedes buscar por categoría"
        titleLabel.textColor = AppStyle.Color.N1
        
        registerCell()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerCell() {
        let nibName = "PYHCategoryCollectionViewCell"
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}


extension PYHPlaceCategoriesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfCategories
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = "PYHCategoryCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! PYHCategoryCollectionViewCell
        
        if let dataSource = dataSource {
            let title = dataSource.placesCategoriesView(self, categoryTitleAt: indexPath.row)
            cell.setTitle(title)
            let image = dataSource.placesCategoriesView(self, categoryImageAt: indexPath.row)
            cell.setImage(image)
        }
        
        return cell
    }
}


extension PYHPlaceCategoriesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        (collectionView.frame.width - CGFloat(numberOfCategories * 50)) / CGFloat((numberOfCategories - 1))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 70)
    }
}
