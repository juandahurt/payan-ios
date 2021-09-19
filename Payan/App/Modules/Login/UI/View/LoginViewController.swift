//
//  LoginViewController.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import UIKit
import RxSwift

final class LoginViewController: UIViewController {
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
    }
    
    private func rxBind() {
        input.isLoading.subscribe(
            onNext: { value in
                // TODO: show loading
            }
        ).disposed(by: disposeBag)
    }
    
    @IBAction func buttonOnPressed(_ sender: UIButton) {
        output.login()
    }
}
