//
//  CarouselViewController.swift
//  Payan
//
//  Created by juandahurt on 10/11/21.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol CarouselDataSource {
    func numberOfItems() -> Int
    func viewForItem(at indexPath: IndexPath) -> UIView
}

class CarouselViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Public
    var dataSource: CarouselDataSource?
    
    // MARK: - Lifecycle
    init() {
        super.init(nibName: String(describing: CarouselViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Console.log("init(coder:) has not been implemented", level: .error)
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        collectionView.dataSource = self
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: - Layout
    private func setupLayout() {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 0
            section.orthogonalScrollingBehavior = .groupPagingCentered
            
            return section
        })
    }
}

// MARK: - DataSource
extension CarouselViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let view = dataSource?.viewForItem(at: indexPath) {
            view.frame = cell.contentView.frame
            cell.contentView.addSubview(view)
        }
        
        return cell
    }
}


#if DEBUG
import SwiftUI

struct DataSource: CarouselDataSource {
    func viewForItem(at indexPath: IndexPath) -> UIView {
        UIHostingController(rootView: DummyView()).view
    }
    
    func numberOfItems() -> Int {
        4
    }
}

struct DummyView: View {
    var body: some View {
        Text("This is only for preview purpuses!")
    }
}

struct CarouselViewControllerPreview: PreviewProvider {
    static var previews: some View {
        let vc = CarouselViewController()
        
        vc.dataSource = DataSource()
        
        return vc.toPreview().preferredColorScheme(.light)
    }
}
#endif
