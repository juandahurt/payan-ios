//
//  PlaceViewController.swift
//  Payan
//
//  Created by juandahurt on 15/11/21.
//

import UIKit
import RxSwift

class PlaceViewController: UIViewController {
    // MARK: - Attributes
    private var input: PlaceViewInput
    private var disposeBag = DisposeBag()
    private var carousel: CarouselViewController!
    
    init(presenter: PlaceViewInput) {
        self.input = presenter
        
        super.init(nibName: String(describing: PlaceViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Console.log("init(coder:) has not been implemented", level: .error)
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
    }
    
    private func configureLayout() {
        carousel = CarouselViewController()
        carousel.dataSource = self
        carousel.view.frame = view.frame
        carousel.view.center = view.center
        
        view.addSubview(carousel.view)
    }
    
    deinit {
        Console.log("\(String(describing: PlaceViewController.self)) is being deallocated", level: .debug)
    }
}

extension PlaceViewController: CarouselDataSource {
    func numberOfItems() -> Int {
        2
    }
    
    func viewForItem(at indexPath: IndexPath) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

        view.backgroundColor = indexPath.row == 0 ? .gray : .black

        return view
    }
}

// MARK: - Preview
#if DEBUG
import SwiftUI

private class PreviewDataSource: PlaceModuleDataSource {
    func providePlace() -> Place {
        Place(
            name: "Preview place",
            type: .bridge,
            imageUrl: ""
        )
    }
}

private struct PlaceViewControllerPreview: PreviewProvider {
    static var previews: some View {
        let navigationController = UINavigationController()
        return PlaceModule.setup(with: navigationController, dataSource: PreviewDataSource()).toPreview()
    }
}
#endif
