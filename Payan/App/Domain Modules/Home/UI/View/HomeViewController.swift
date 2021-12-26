//
//  HomeViewController.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import RxCocoa
import RxSwift
import SkeletonView
import UIKit


class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
        }
    }
    
    // MARK: - Attributes
    var input: HomeViewInput
    var output: HomeViewOutput
    private let disposeBag = DisposeBag()
    private lazy var dataSource = createDataSource()
    private var refresher: UIRefreshControl!
    
    // MARK: - Value types
    typealias DataSource = UICollectionViewDiffableDataSource<HomeSection, HomeSectionItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeSectionItem>
    
    init(presenter: HomeViewInput & HomeViewOutput) {
        input = presenter
        output = presenter
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Console.log("init(coder:) has not been implemented", level: .error)
        fatalError()
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSupplementaryViews()
        collectionView.dataSource = dataSource
        setupRefresher()
        configureLayout()
        rxBind()
        output.getData(usingRefresh: false)
    }
    
    // MARK: - Refresher
    private func setupRefresher() {
        refresher = UIRefreshControl()
        collectionView.refreshControl = refresher
    }
    
    // MARK: - Collection view layout
    private func setupSupplementaryViews() {
        dataSource.supplementaryViewProvider = { [weak self] supplementaryView, elementKind, indexPath in
            guard let self = self else {
                return nil
            }
            
            if elementKind == UICollectionView.elementKindSectionHeader {
                let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: String(describing: SectionHeaderView.self), for: indexPath) as? SectionHeaderView
                let title = self.input.titleForSection(atIndex: indexPath.section)
                
                header?.setup(text: title)
                
                return header
            }
            
            return nil
        }
    }
    
    private func configureLayout() {
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: SectionHeaderView.self))
        let placeCellId = String(describing: PlaceCell.self)
        collectionView.register(UINib(nibName: placeCellId, bundle: nil), forCellWithReuseIdentifier: placeCellId)
        
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let sectionType = self.input.sectionType(forIndex: sectionIndex) else {
                return nil
            }
            switch sectionType {
            case .place:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(164), heightDimension: .absolute(195))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 0
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [header]
                section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                return section
            }
        })
    }
    
    private func createDataSource() -> DataSource {
        DataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item -> UICollectionViewCell? in
                switch item {
                case is HomeLoadingItem:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlaceCell.self), for: indexPath) as? PlaceCell
                    cell?.showSkeletonAnimation()
                    return cell
                case is HomePlaceItem:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlaceCell.self), for: indexPath) as? PlaceCell
                    cell?.hideSkeleton()
                    cell?.setup(place: (item as! HomePlaceItem).place)
                    return cell
                default:
                    return nil
                }
            }
        )
    }
    
    private func applySnapshot(sections: [HomeSection]) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot)
    }
    
    // MARK: - Rx
    private func rxBind() {
        input.sectionsDriver
            .drive(onNext: { [weak self] sections in
                guard let self = self else { return }
                if let refreshControl = self.collectionView.refreshControl, refreshControl.isRefreshing {
                    self.collectionView.refreshControl?.endRefreshing()
                }
                self.applySnapshot(sections: sections)
            }).disposed(by: disposeBag)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        if let item = item as? HomePlaceItem {
            output.showPlace(item.place)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if refresher.isRefreshing {
            output.getData(usingRefresh: true)
        }
    }
}

// MARK: - Preview
#if DEBUG
import SwiftUI

struct HomeViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SkeletonAppearance.default.tintColor = Color.skeleton
        let nav = UINavigationController()
        return HomeModule.setup(with: nav).toPreview().preferredColorScheme(.light)
    }
}
#endif
