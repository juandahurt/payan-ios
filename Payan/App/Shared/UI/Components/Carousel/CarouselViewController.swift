//
//  CarouselViewController.swift
//  Payan
//
//  Created by juandahurt on 10/11/21.
//

import UIKit
import RxCocoa
import RxSwift

private let reuseIdentifier = "Cell"

protocol CarouselDataSource {
    func numberOfItems() -> Int
    func viewForItem(at indexPath: IndexPath) -> UIView
}

class CarouselViewController: UIViewController {
    @IBOutlet weak var lastViewButton: UIButton! {
        didSet {
            lastViewButton.rx.tap.bind(onNext: { [weak self] in
                self?.scrollToLastView()
                self?.updateButtonsInteraction()
            }).disposed(by: disposeBag)
        }
    }
    @IBOutlet weak var nextViewButton: UIButton! {
        didSet {
            nextViewButton.rx.tap.bind(onNext: { [weak self] in
                self?.scrollToNextView()
                self?.updateButtonsInteraction()
            }).disposed(by: disposeBag)
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Public
    var dataSource: CarouselDataSource?
    
    // MARK: - Private
    private var disposeBag = DisposeBag()
    private var currentIndex = 0
    private let numberOfItems: Int
    
    // MARK: - Lifecycle
    init(dataSource: CarouselDataSource?) {
        self.dataSource = dataSource
        numberOfItems = dataSource?.numberOfItems() ?? 0
        
        super.init(nibName: String(describing: CarouselViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Console.log("init(coder:) has not been implemented", level: .error)
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateButtonsInteraction()
        setupLayout()
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: - Layout
    private func setupLayout() {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 0
            
            return section
        })
    }
    
    private func scrollToLastView() {
        if currentIndex > 0 {
            currentIndex -= 1
            let indexPath = IndexPath(item: currentIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }
    
    private func scrollToNextView() {
        if currentIndex < numberOfItems - 1 {
            currentIndex += 1
            let indexPath = IndexPath(item: currentIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    private func updateButtonsInteraction() {
        guard numberOfItems > 0 else { return }
        
        if currentIndex == 0 {
            disableButton(lastViewButton)
            
        } else {
            enableButton(lastViewButton)
        }
        
        if currentIndex == numberOfItems - 1 {
            disableButton(nextViewButton)
        } else {
            enableButton(nextViewButton)
        }
    }
    
    private func disableButton(_ button: UIButton) {
        button.isUserInteractionEnabled = false
        button.alpha = 0.25
    }
    
    private func enableButton(_ button: UIButton) {
        button.isUserInteractionEnabled = true
        button.alpha = 1
    }
}

// MARK: - DataSource
extension CarouselViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfItems
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
        let vc = CarouselViewController(dataSource: DataSource())
        
        return vc.toPreview().preferredColorScheme(.light)
    }
}
#endif
