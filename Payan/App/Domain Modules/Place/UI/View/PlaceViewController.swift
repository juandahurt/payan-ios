//
//  PlaceViewController.swift
//  Payan
//
//  Created by juandahurt on 15/11/21.
//

import UIKit
import RxSwift

class PlaceViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFill
            if let url = URL(string: input.selectedPlace.imageUrl) {
                imageView.kf.setImage(with: url)
            }
        }
    }
    
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
        addGradient()
    }
    
    private func configureLayout() {
        carousel = CarouselViewController()
        carousel.dataSource = self
        carousel.view.frame = view.frame
        carousel.view.center = view.center
        
        view.addSubview(carousel.view)
    }
    
    private func addGradient() {
        let gradient = CAGradientLayer()

        gradient.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.cgColor]
        gradient.frame = view.frame

        imageView.layer.addSublayer(gradient)
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
        if indexPath.row == 0 {
            return PlaceTitleViewController(placeDetails: input.selectedPlace).view
        } else {
            return PlaceDescriptionViewController(placeDetails: input.selectedPlace).view
        }
    }
}
//
//// MARK: - Preview
//#if DEBUG
//import SwiftUI
//
//private class PreviewDataSource: PlaceModuleDataSource {
//    func providePlace() -> Place {
//        Place(
//            name: "Preview place",
//            type: .bridge,
//            imageUrl: "https://media.traveler.es/photos/61376f8bd4923f67e298ef5b/master/w_1600,c_limit/130738.jpg"
//        )
//    }
//}
//
//private struct PlaceViewControllerPreview: PreviewProvider {
//    static var previews: some View {
//        let navigationController = UINavigationController()
//        return PlaceModule.setup(with: navigationController, dataSource: PreviewDataSource()).toPreview()
//    }
//}
//#endif
