//
//  PYHHomeViewController.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import UIKit

class PYHViewController: PYBaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: PYHBusinessLogic
    var router: PYHRoutingLogic
    
    private var tabBarHasBeenHiddenOnce = false
    
    typealias DataSource = UICollectionViewDiffableDataSource<PYHSection, PYHSectionItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<PYHSection, PYHSectionItem>
    
    lazy var dataSource: DataSource = makeDataSource()
    
    var sections: [PYHSection] = []
    
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
        
        view.backgroundColor = AppStyle.Color.F2
        setupCollectionView()
        
        interactor.getHomeData()
    }
    
    private func setupCollectionView() {
        registerHeader()
        registerCells()
        setupLayout()
        setupHeaders()
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.backgroundColor = AppStyle.Color.F2
    }
    
    private func registerCells() {
        let collectionNibName = String(describing: PYHCollectionCollectionViewCell.self)
        collectionView.register(UINib(nibName: collectionNibName, bundle: nil), forCellWithReuseIdentifier: PYHCollectionCollectionViewCell.reuseIdentifier)
        
        let basicNibName = String(describing: PYHBasicCollectionViewCell.self)
        collectionView.register(UINib(nibName: basicNibName, bundle: nil), forCellWithReuseIdentifier: PYHBasicCollectionViewCell.reuseIdentifier)
        
        let innerCardNibName = String(describing: PYHInnerCardCollectionViewCell.self)
        collectionView.register(UINib(nibName: innerCardNibName, bundle: nil), forCellWithReuseIdentifier: PYHInnerCardCollectionViewCell.reuseIdentifier)
    }
    
    private func registerHeader() {
        let headerNibName = String(describing: PYHHeaderCollectionReusableView.self)
        collectionView.register(UINib(nibName: headerNibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PYHHeaderCollectionReusableView.reuseIdentifier)
    }
    
    private func makeDataSource() -> DataSource {
        DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, _ in
            guard let self = self else { return nil }
            let currentSection = self.sections[indexPath.section]
            return PYHSectionItemFactory.createSectionItemCell(for: currentSection.itemLayout, inside: collectionView, indexPath: indexPath)
        }
    }
    
    private func setupLayout() {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let currentSection = self.sections[sectionIndex]
            return PYHSectionLayoutFactory.createSectionLayout(for: currentSection)
        })
    }
    
    func setupHeaders() {
        dataSource.supplementaryViewProvider = { [weak self] supplementaryView, elementKind, indexPath in
            guard let self = self else { return nil }
            
            if elementKind == UICollectionView.elementKindSectionHeader {
                let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PYHHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! PYHHeaderCollectionReusableView
                header.secondaryButton.isHidden = true
                if indexPath.section == 2 {
                    header.titleLabel.text = "Próceres"
                    header.subtitleLabel.removeFromSuperview()
                }
                if indexPath.section == 1 {
                    header.titleLabel.text = "Universidades"
                    header.subtitleLabel.removeFromSuperview()
                    header.secondaryButton.isHidden = false
                    header.secondaryButton.setTitle("Ver todas", for: .normal)
                }
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
}


extension PYHViewController: PYHViewLogic {
    func showLoading() {
        
    }
    
    func renderSections(_ sections: [PYHSection]) {
        self.sections = sections
        var snapshot = Snapshot()
        
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource.apply(snapshot)
    }
}

extension PYHViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router.showCategory()
    }
}
