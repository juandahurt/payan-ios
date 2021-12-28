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
    private var output: PlaceViewOutput
    private var disposeBag = DisposeBag()
    private var carousel: CarouselViewController!
    
    init(presenter: PlaceViewInput & PlaceViewOutput) {
        input = presenter
        output = presenter
        
        super.init(nibName: String(describing: PlaceViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Console.log("init(coder:) has not been implemented", level: .error)
        fatalError()
    }
    
    deinit {
        Console.log("\(String(describing: PlaceViewController.self)) is being deallocated", level: .debug)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        addGradient()
        addDismissButton()
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
    
    private func addDismissButton() {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top
        let button = UtilButton(frame: .init(x: view.frame.width - 100, y: (topPadding ?? 0) + 25, width: 40, height: 40))
        
        button.setImage(UIImage(named: "close"), for: .normal)
        button.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else {
                return
            }
            self.output.dismiss()
        }).disposed(by: disposeBag)
        
        view.addSubview(button)
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
