//
//  PYElementViewController.swift
//  Payan
//
//  Created by Juan Hurtado on 10/04/22.
//

import UIKit

class PYElementViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let interactor: PYElementBusinessLogic
    var id: String = ""
    
    typealias DataSource = UICollectionViewDiffableDataSource<PYElementSection, PYElementSectionItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PYElementSection, PYElementSectionItem>
    
    lazy var dataSource = createDataSource()
    
    init(interactor: PYElementBusinessLogic) {
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
        interactor.getElementData()
    }
    
    private func setupCollectionView() {
        registerCells()
        setupLayout()
        collectionView.dataSource = dataSource
    }
    
    private func setupLayout() {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalHeight(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.4)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 30, trailing: 0)
            
            return section
        })
    }
    
    private func registerCells() {
        let imageNibName = String(describing: PYElementImageCollectionViewCell.self)
        collectionView.register(UINib(nibName: imageNibName, bundle: nil), forCellWithReuseIdentifier: PYElementImageCollectionViewCell.reuseIdentifier)
    }
    
    private func createDataSource() -> DataSource {
        DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYElementImageCollectionViewCell.reuseIdentifier, for: indexPath) as! PYElementImageCollectionViewCell
            cell.setImage("http://www.radiosuperpopayan.com/wp-content/uploads/2018/08/museo-natural.jpg")
            return cell
        }
    }
    
    private func setupSubviews() {
        view.backgroundColor = AppStyle.Color.F2
        setupCollectionView()
    }
}

extension PYElementViewController: PYElementViewLogic {
    func renderSections(_ sections: [PYElementSection]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
