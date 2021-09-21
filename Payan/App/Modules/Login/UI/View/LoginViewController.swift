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
    @IBOutlet weak var loginButton: MainButton! {
        didSet {
            loginButton.setTitle("Iniciar sesión", for: .normal)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "¡Bienvenido a Payán!"
            titleLabel.textColor = .black
            titleLabel.font = Font.get(.semiBold, size: .header)
        }
    }
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.text = "La ciudad blanca"
            subtitleLabel.textColor = .black
            subtitleLabel.font = Font.get(.regular, size: .subtitle)
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
            self?.output.login()
        }).disposed(by: disposeBag)
        
        input.isLoading.subscribe(
            onNext: { [weak self] loading in
                if loading {
                    self?.loginButton.showLoader()
                } else {
                    self?.loginButton.hideLoader()
                }
            }
        ).disposed(by: disposeBag)
        
        output.username
            .bind(to: userTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.password
            .bind(to: passwordTextField.rx.text)
            .disposed(by: disposeBag)
    }
}
