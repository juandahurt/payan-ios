//
//  PYHHomeViewController.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import UIKit

class PYHHomeViewController: PYBaseViewController {
    @IBOutlet private weak var hiLabel: UILabel!
    @IBOutlet private weak var categoriesView: PYHPlaceCategoriesView!
    
    private let interactor: PYHInteractor
    
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
        
        showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.hideLoading()
        }
    }
    
    private func setupSubviews() {
        view.backgroundColor = AppStyle.Color.N8
        
        hiLabel.font = AppStyle.Font.get(.semiBold, size: .title)
        hiLabel.text = "Buenos días"
        hiLabel.textColor = AppStyle.Color.N1
        
        categoriesView.contentView.layer.cornerRadius = 8
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
