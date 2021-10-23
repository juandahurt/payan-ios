//
//  LoginViewController.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: ScrollableViewController {
    @IBOutlet weak var loginButton: MainButton! {
        didSet {
            loginButton.setTitle("Iniciar sesión", for: .normal)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "Inicia sesión"
            titleLabel.textColor = .black
            titleLabel.font = Font.get(.semiBold, size: .header)
        }
    }
    @IBOutlet weak var userTextField: TextFieldForm! {
        didSet {
            userTextField.placeholder = "Usuario"
        }
    }
    @IBOutlet weak var passwordTextField: TextFieldForm! {
        didSet {
            passwordTextField.placeholder = "Contraseña"
            passwordTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var mainScrollView: UIScrollView! {
        didSet {
            scrollView = mainScrollView
        }
    }
    
    var output: LoginViewOutput
    var input: LoginViewInput
    
    private let disposeBag = DisposeBag()
    
    init(presenter: LoginViewOutput & LoginViewInput) {
        self.output = presenter
        self.input = presenter
        super.init(nibName: String(describing: LoginViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Console.log("init(coder:) has not been implemented", level: .error)
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rxBind()
    }
    
    private func rxBind() {
        loginButton.rx.tap.bind(onNext: { [weak self] in
            self?.view.endEditing(true)
            self?.output.login()
        }).disposed(by: disposeBag)
        
        input.loadingPublisher.subscribe(
            onNext: { [weak self] loading in
                if loading {
                    self?.loginButton.showLoader()
                } else {
                    self?.loginButton.hideLoader()
                }
            }
        ).disposed(by: disposeBag)
        
        userTextField.rx.text
            .bind(to: output.usernameSubject)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .bind(to: output.passwordSubject)
            .disposed(by: disposeBag)
    }
}
