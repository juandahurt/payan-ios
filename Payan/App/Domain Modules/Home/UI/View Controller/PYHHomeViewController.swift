//
//  PYHHomeViewController.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import UIKit
import CoreGraphics

class PYHHomeViewController: PYBaseViewController, PYHViewLogic {
    @IBOutlet private weak var hiLabel: UILabel!
    @IBOutlet private weak var categoriesView: PYHPlaceCategoriesView!
    
    var interactor: PYHInteractor
    
    init(interactor: PYHInteractor) {
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
        setupShadows()
        
        interactor.checkCurrentVersion()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setTabBarVisible(visible: false, animated: false)
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
    
    private func setupSubviews() {
        
        
//        tabBarController?.tabBar.transform = .init(translationX: 0, y: 20)
//        self.view.transform = CGAffineTransform(translationX: 0, y: 200)
//        tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 200)
//        tabBarController?.tabBar.alpha = 0
//        tabBarController?.tabBar.center = tabBarController?.tabBar.center.applying(.init(translationX: 0, y: 50)) ?? tabBarController?.tabBar.center as! CGPoint
        
        view.backgroundColor = AppStyle.Color.F1
        
        hiLabel.font = AppStyle.Font.get(.semiBold, size: .title)
        hiLabel.text = "Buenos días"
        hiLabel.textColor = AppStyle.Color.N1
        
        categoriesView.contentView.layer.cornerRadius = 5
        categoriesView.dataSource = self
    }
    
    private func setupShadows() {
        categoriesView.contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        categoriesView.contentView.layer.shadowOffset = .init(width: 0, height: 4)
        categoriesView.contentView.layer.shadowRadius = 25
        categoriesView.contentView.layer.shadowOpacity = 1
    }
}


extension PYHHomeViewController: PYHPlaceCategoriesViewDataSource {
    func placesCategoriesView(numberOfCategoriesIn view: PYHPlaceCategoriesView) -> Int {
        4
    }
    
    func placesCategoriesView(_ view: PYHPlaceCategoriesView, categoryTitleAt index: Int) -> String {
        let categories = ["Iglesias", "Museos", "Parques", "Puentes"]
        return categories[index]
    }
    
    func placesCategoriesView(_ view: PYHPlaceCategoriesView, categoryImageAt index: Int) -> UIImage {
        UIImage(named: "museum")!
    }
}
