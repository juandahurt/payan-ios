//
//  AppUpdateBottomSheet.swift
//  Payan
//
//  Created by juandahurt on 24/10/21.
//

import UIKit
import RxSwift

class AppUpdateViewController: UIViewController {
    @IBOutlet weak var updateButton: MainButton! {
        didSet {
            updateButton.setTitle("Actualizar", for: .normal)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "¡Nueva actualización!"
            titleLabel.font = Font.get(.semiBold, size: .title)
        }
    }
    @IBOutlet weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.backgroundColor = Color.background
            descriptionTextView.text = "Te recomendamos actualizar la app para que puedas disfrutar de la mejor experiencia."
            descriptionTextView.font = Font.get(.regular, size: .body)
            descriptionTextView.isEditable = false
        }
    }
    
    // MARK: - Private
    private var output: AppUpdateViewOutput
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    init(presenter: AppUpdateViewOutput) {
        output = presenter
        
        super.init(nibName: String(describing: AppUpdateViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rxBind()
    }
    
    // MARK: - Rx
    private func rxBind() {
        updateButton.rx.tap.bind(onNext: { [weak self] in
            self?.output.dismissUpdate()
        }).disposed(by: disposeBag)
    }
}


// MARK: UIBottomSheetDataSource
extension AppUpdateViewController: UIBottomSheetDataSource {
    func embeddedView() -> UIView {
        view
    }
}
