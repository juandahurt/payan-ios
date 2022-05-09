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
    var sections: [PYElementSection] = []
    
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
        interactor.getElementData(id: id)
    }
    
    private func setupCollectionView() {
        registerCells()
        setupLayout()
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.backgroundColor = AppStyle.Color.F2
    }
    
    private func setupLayout() {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section.itemLayout {
            case .image:
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
            case .title, .text:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(40)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 20, bottom: 30, trailing: 20)
                
                return section
            }
        })
    }
    
    private func registerCells() {
        let imageNibName = String(describing: PYElementImageCollectionViewCell.self)
        collectionView.register(UINib(nibName: imageNibName, bundle: nil), forCellWithReuseIdentifier: PYElementImageCollectionViewCell.reuseIdentifier)
        
        let titleNibName = String(describing: PYElementTitleCollectionViewCell.self)
        collectionView.register(UINib(nibName: titleNibName, bundle: nil), forCellWithReuseIdentifier: PYElementTitleCollectionViewCell.reuseIdentifier)
        
        let textNibName = String(describing: PYElementTextCollectionViewCell.self)
        collectionView.register(UINib(nibName: textNibName, bundle: nil), forCellWithReuseIdentifier: PYElementTextCollectionViewCell.reuseIdentifier)
    }
    
    private func createDataSource() -> DataSource {
        DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            guard let self = self else { return nil }
            let layout = self.sections[indexPath.section].itemLayout
            switch layout {
            case .image:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYElementImageCollectionViewCell.reuseIdentifier, for: indexPath) as! PYElementImageCollectionViewCell
                if item is PYElementSectionLoadingItem {
                    cell.showAnimatedSkeleton()
                } else {
                    if let image = item.image {
                        cell.setImage(image)
                    }
                }
                return cell
            case .title:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYElementTitleCollectionViewCell.reuseIdentifier, for: indexPath) as! PYElementTitleCollectionViewCell
                if item is PYElementSectionLoadingItem {
                    cell.showAnimatedSkeleton()
                } else {
                    if let title = item.title, let subtitle = item.subtitle {
                        cell.setTitle(title)
                        cell.setSubtitle(subtitle)
                    }
                }
                return cell
            case .text:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYElementTextCollectionViewCell.reuseIdentifier, for: indexPath) as! PYElementTextCollectionViewCell
                if item is PYElementSectionLoadingItem {
                    cell.showAnimatedSkeleton()
                } else {
                    if let content = item.content {
                        cell.setContent(content)
                    }
                }
                return cell
            }
        }
    }
    
    private func setupSubviews() {
        view.backgroundColor = AppStyle.Color.F2
        setupCollectionView()
    }
}

extension PYElementViewController: PYElementViewLogic {
    func renderSections(_ sections: [PYElementSection]) {
        self.sections = sections
        var snapshot = Snapshot()
        
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension PYElementViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let index = sections.firstIndex(where: { $0.itemLayout == .image }) else { return }
        guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: index)) else { return }
        if scrollView.contentOffset.y > 10 {
            UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: []) {
                cell.contentView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            }
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: []) {
                cell.contentView.transform = .identity
            }
        }
    }
}
