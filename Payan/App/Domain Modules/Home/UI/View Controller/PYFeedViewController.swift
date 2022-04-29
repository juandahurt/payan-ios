//
//  PYFeedViewController.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import SkeletonView
import UIKit

class PYFeedViewController: PYBaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: PYFeedBusinessLogic
    var router: PYFeedRoutingLogic
    
    private var tabBarHasBeenHiddenOnce = false
    
    typealias DataSource = UICollectionViewDiffableDataSource<PYFeedSection, PYFeedSectionItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PYFeedSection, PYFeedSectionItem>
    
    lazy var dataSource: DataSource = makeDataSource()
    
    var sections: [PYFeedSection] = []
    
    init(interactor: PYFeedBusinessLogic, router: PYFeedRoutingLogic) {
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
        interactor.getHomeData()
    }
    
    private func setupSubviews() {
        title = "Payán"
        view.backgroundColor = AppStyle.Color.F2
        setupCollectionView()
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setupCollectionView() {
        registerHeader()
        registerCells()
        setupLayout()
        setupHeaders()
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.backgroundColor = AppStyle.Color.F2
        let bottomSafeAreaInset = view.safeAreaInsets.bottom
        collectionView.contentInset = .init(top: 0, left: 0, bottom: bottomSafeAreaInset, right: 0)
    }
    
    private func registerCells() {
        let collectionNibName = String(describing: PYFeedCollectionCollectionViewCell.self)
        collectionView.register(UINib(nibName: collectionNibName, bundle: nil), forCellWithReuseIdentifier: PYFeedCollectionCollectionViewCell.reuseIdentifier)
        
        let basicNibName = String(describing: PYFeedBasicCollectionViewCell.self)
        collectionView.register(UINib(nibName: basicNibName, bundle: nil), forCellWithReuseIdentifier: PYFeedBasicCollectionViewCell.reuseIdentifier)
        
        let innerCardNibName = String(describing: PYFeedInnerCardCollectionViewCell.self)
        collectionView.register(UINib(nibName: innerCardNibName, bundle: nil), forCellWithReuseIdentifier: PYFeedInnerCardCollectionViewCell.reuseIdentifier)
    }
    
    private func registerHeader() {
        let headerNibName = String(describing: PYFeedHeaderCollectionReusableView.self)
        collectionView.register(UINib(nibName: headerNibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PYFeedHeaderCollectionReusableView.reuseIdentifier)
    }
    
    private func makeDataSource() -> DataSource {
        DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            guard let self = self else { return nil }
            let currentSection = self.sections[indexPath.section]
            let cell = PYFeedSectionItemFactory.createSectionItemCell(for: currentSection.itemLayout.type, item: item, inside: collectionView, indexPath: indexPath)
            if item is PYFeedLoadingSectionItem {
                cell.showAnimatedSkeleton()
            }
            return cell
        }
    }
    
    private func setupLayout() {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let currentSection = self.sections[sectionIndex]
            return PYFeedSectionLayoutFactory.createSectionLayout(for: currentSection)
        })
    }
    
    func setupHeaders() {
        dataSource.supplementaryViewProvider = { [weak self] supplementaryView, elementKind, indexPath in
            guard let self = self else { return nil }
            
            if elementKind == UICollectionView.elementKindSectionHeader {
                let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PYFeedHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! PYFeedHeaderCollectionReusableView
                let currentSection = self.sections[indexPath.section]
                header.title = currentSection.header.title
                header.subtitle = currentSection.header.subtitle
                header.buttonTitle = currentSection.header.secondaryButton?.title
                header.backgroundColor = AppStyle.Color.F2
                return header
            }
            
            return nil
        }
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
    
    private func isLoading() -> Bool {
        return sections.first(where: { $0.items.contains(where: { $0 is PYFeedLoadingSectionItem }) }) != nil
    }
}


extension PYFeedViewController: PYFeedViewLogic {
    func renderSections(_ sections: [PYFeedSection]) {
        self.sections = sections
        var snapshot = Snapshot()
        
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
        collectionView.isUserInteractionEnabled = !isLoading()
    }
    
    func showGenericError() {
        showGenericError { [weak self] in
            guard let self = self else { return }
            self.interactor.getHomeData()
        }
    }
}

extension PYFeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: sections[indexPath.section].items[indexPath.row].link) else { return }
        PYRoutingManager.shared.open(url: url)
    }
}
