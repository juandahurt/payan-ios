//
//  PYHHomeViewController.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import UIKit
import CoreGraphics

#warning("TODO: find a way to get the categories and set them to the corresponding view")

class PYHViewController: PYBaseViewController, PYHViewLogic {
    @IBOutlet private weak var hiLabel: UILabel!
    @IBOutlet private weak var categoriesView: PYHPlaceCategoriesView!
    
    var interactor: PYHBusinessLogic
    var router: PYHRoutingLogic
    
    private var tabBarHasBeenHiddenOnce = false
    
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
        title = "Home"
        
        setupSubviews()
        setupShadows()
        
        interactor.checkCurrentVersion()
        interactor.checkCurrentTime()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !tabBarHasBeenHiddenOnce {
            setTabBarVisible(visible: false, animated: false)
            tabBarHasBeenHiddenOnce = true
        }
    }
    
    func showLoading() {
        super.showLoading()
    }
    
    override func hideLoading() {
        super.hideLoading()
        
        setTabBarVisible(visible: true, animated: true)
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
    
    func updateHiLabel(with text: String) {
        hiLabel.text = text
    }
    
    private func setupSubviews() {
        navigationBarIsHidden = true
        view.backgroundColor = AppStyle.Color.F1
        
        hiLabel.font = AppStyle.Font.get(.semiBold, size: .title)
        hiLabel.text = "Buenos días"
        hiLabel.textColor = AppStyle.Color.N1
        
        categoriesView.contentView.layer.cornerRadius = 5
        categoriesView.dataSource = self
        categoriesView.delegate = self
    }
    
    private func setupShadows() {
        categoriesView.contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        categoriesView.contentView.layer.shadowOffset = .init(width: 0, height: 6)
        categoriesView.contentView.layer.shadowRadius = 16
        categoriesView.contentView.layer.shadowOpacity = 1
    }
}


extension PYHViewController: PYHPlaceCategoriesViewDataSource {
    func placesCategoriesView(numberOfCategoriesIn view: PYHPlaceCategoriesView) -> Int {
        4
    }
    
    func placesCategoriesView(_ view: PYHPlaceCategoriesView, categoryTitleAt index: Int) -> String {
        let categories = ["Iglesias", "Museos", "Parques", "Puentes"]
        return categories[index]
    }
    
    func placesCategoriesView(_ view: PYHPlaceCategoriesView, categoryImageAt index: Int) -> UIImage {
        if index == 0 {
            return UIImage(named: "church")!
        } else if index == 1 {
            return UIImage(named: "museum")!
        } else if index == 2 {
            return UIImage(named: "park")!
        } else {
            return UIImage(named: "bridge")!
        }
    }
}


extension PYHViewController: PYHPlaceCategoriesViewDelegate {
    func placesCategoriesView(_ view: PYHPlaceCategoriesView, didSelectCategoryAt index: Int) {
        router.showCategory()
    }
}
