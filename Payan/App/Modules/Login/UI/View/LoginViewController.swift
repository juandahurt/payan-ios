//
//  LoginViewController.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: MainButton!
    
    var output: LoginViewOutput
    var input: LoginViewInput
    
    private let disposeBag = DisposeBag()
    
    init(presenter: LoginViewOutput & LoginViewInput) {
        self.output = presenter
        self.input = presenter
        super.init(nibName: String(describing: LoginViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rxBind()
        setupUI()
    }
    
    private func rxBind() {
        input.isLoading.subscribe(
            onNext: { [weak self] loading in
                if loading {
                    self?.loginButton.showLoader()
                } else {
                    self?.loginButton.hideLoader()
                }
            }
        ).disposed(by: disposeBag)
        loginButton.rx.tap.bind(onNext: { [weak self] in
            self?.output.login()
        }).disposed(by: disposeBag)
    }
    
    private func setupUI() {
        loginButton.setTitle("Iniciar sesión", for: .normal)
    }
}
