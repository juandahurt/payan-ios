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
    @IBOutlet weak var dismissButton: SecondaryButton! {
        didSet {
            dismissButton.setTitle("Omitir", for: .normal)
        }
    }
    @IBOutlet weak var dismissButtonHeight: NSLayoutConstraint!
    
    // MARK: - Private
    private var output: AppUpdateViewOutput
    private var input: AppUpdateViewInput
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    init(presenter: AppUpdateViewOutput & AppUpdateViewInput) {
        output = presenter
        input = presenter
        
        super.init(nibName: String(describing: AppUpdateViewController.self), bundle: nil)
    }
    
    deinit {
        Console.log("\(String(describing: Self.self)) is being deallocated", level: .debug)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rxBind()
        updateUI()
    }
    
    // MARK: - Rx
    private func rxBind() {
        updateButton.rx.tap.bind(onNext: { [weak self] in
            self?.output.update()
        }).disposed(by: disposeBag)
        
        dismissButton.rx.tap.bind(onNext: { [weak self] in
            self?.output.dismissUpdate()
        }).disposed(by: disposeBag)
    }
    
    private func updateUI() {
        if input.versionType == .mandatory {
            dismissButtonHeight.constant = 0
            dismissButton.isHidden = true
            
            titleLabel.text = "Lo sentimos"
            descriptionTextView.text = "Parece que tienes una version desactualizada de la aplicacion. Para que puedas continuar disfrutando de Payan, debes actualizarla."
            
            view.layoutIfNeeded()
        }
    }
}


// MARK: UIBottomSheetDataSource
extension AppUpdateViewController: UIBottomSheetDataSource {
    func embeddedView() -> UIView {
        view
    }
}
