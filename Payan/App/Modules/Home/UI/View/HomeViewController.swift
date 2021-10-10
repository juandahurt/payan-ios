//
//  HomeViewController.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import UIKit
import RxSwift
import SkeletonView

class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Attributes
    var input: HomeViewInput
    var output: HomeViewOutput
    private let disposeBag = DisposeBag()
    private lazy var dataSource = createDataSource()
    
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
        collectionView.dataSource = dataSource
        configureLayout()
        rxBind()
        output.getData()
    }
    
    // MARK: - Collection view layout
    private func configureLayout() {
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
                group.contentInsets = .init(top: 20, leading: 20, bottom: 0, trailing: 20)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.orthogonalScrollingBehavior = .continuous
                
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
                self.applySnapshot(sections: sections)
            }).disposed(by: disposeBag)
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
