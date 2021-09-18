//
//  LoginViewController.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import UIKit

final class LoginViewController: UIViewController {
    var output: LoginViewOutput
    
    init(presenter: LoginViewOutput) {
        self.output = presenter
        super.init(nibName: String(describing: LoginViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonOnPressed(_ sender: UIButton) {
        output.login()
    }
}
