//
//  PYHHomeViewController.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import UIKit

class PYHViewController: PYBaseViewController, PYHViewLogic {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: PYHBusinessLogic
    var router: PYHRoutingLogic
    
    private var tabBarHasBeenHiddenOnce = false
    
    typealias DataSource = UICollectionViewDiffableDataSource<PYHSection, PYHSectionItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PYHSection, PYHSectionItem>
    
    lazy var dataSource: DataSource = makeDataSource()
    
    init(interactor: PYHBusinessLogic, router: PYHRoutingLogic) {
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
        registerHeader()
        registerCells()
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        setupLayout()
        setupHeaders()
        applySnapshot()
        collectionView.backgroundColor = AppStyle.Color.F2
        view.backgroundColor = AppStyle.Color.F2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !tabBarHasBeenHiddenOnce {
            setTabBarVisible(visible: false, animated: false)
            tabBarHasBeenHiddenOnce = true
        }
    }
    
    private func registerCells() {
        let collectionNibName = String(describing: PYHCollectionCollectionViewCell.self)
        collectionView.register(UINib(nibName: collectionNibName, bundle: nil), forCellWithReuseIdentifier: PYHCollectionCollectionViewCell.reuseIdentifier)
    }
    
    private func registerHeader() {
        let headerNibName = String(describing: PYHHeaderCollectionReusableView.self)
        collectionView.register(UINib(nibName: headerNibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PYHHeaderCollectionReusableView.reuseIdentifier)
    }
    
    private func makeDataSource() -> DataSource {
        DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYHCollectionCollectionViewCell.reuseIdentifier, for: indexPath)
            return cell
        }
    }
    
    private func setupLayout() {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { section, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalHeight(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 7.5, bottom: 0, trailing: 7.5)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(140)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            group.contentInsets = .init(top: 15, leading: 12.5, bottom: 0, trailing: 12.5)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            header.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)

            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header]
            
            return section
        })
    }
    
    func setupHeaders() {
        dataSource.supplementaryViewProvider = { [weak self] supplementaryView, elementKind, indexPath in
            guard let self = self else { return nil }
            
            if elementKind == UICollectionView.elementKindSectionHeader {
                let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PYHHeaderCollectionReusableView.reuseIdentifier, for: indexPath)
//                header.backgroundColor = .gray
                return header
            }
            
            return nil
        }
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        let section = PYHSection()
        snapshot.appendSections([section])
        snapshot.appendItems(
            [
                PYHSectionItem(),
                PYHSectionItem(),
                PYHSectionItem(),
                PYHSectionItem()
            ],
            toSection: section
        )
        dataSource.apply(snapshot)
    }

    func showLoading() {
        super.showLoading()
    }

    override func hideLoading() {
        super.hideLoading()

        setTabBarVisible(visible: true, animated: true)
    }

    func showUpdateModal(image: UIImage, title: String, content: String, dismissable: Bool) {
        guard let parent = parent else { return }

        let config = PYModalConfig(
            image: image,
            height: 350,
            title: title,
            content: content,
            mainButtonTitle: "Actualizar",
            isDismissable: dismissable
        )
        PYModalManager.shared.showModal(using: config, inside: parent)
    }

    func updateHiLabel(with text: String) {
//        hiLabel.text = text
    }
}


extension PYHViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router.showCategory()
    }
}
