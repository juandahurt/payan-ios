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

protocol CarouselDataSource: AnyObject {
    func numberOfItems() -> Int
    func viewForItem(at indexPath: IndexPath) -> UIView
}

class CarouselViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Public
    weak open var dataSource: CarouselDataSource? {
        didSet {
            numberOfItems = dataSource?.numberOfItems() ?? 0
        }
    }
    
    // MARK: - Private
    private var currentIndex = 0
    private var numberOfItems = 0
    
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
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .clear
        setupBackground()
    }
    
    private func setupBackground() {
        view.backgroundColor = .clear
    }

    // MARK: - Layout
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
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

// MARK: - Layout Delegate
extension CarouselViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
}

#if DEBUG
import SwiftUI

class DataSource: CarouselDataSource {
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
    private static var dataSource = DataSource()
    private static let vc = CarouselViewController()
    
    static var previews: some View {
        vc.dataSource = dataSource
        
        return vc.toPreview().preferredColorScheme(.light)
    }
}
#endif
