//
//  PYGenericErrorViewController.swift
//  Payan
//
//  Created by Juan Hurtado on 25/04/22.
//

import UIKit

protocol PYGenericErrorDelegate: AnyObject {
    func didDisappearError()
}

class PYGenericErrorViewController: UIViewController {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var retryButton: PYButton!
    
    var onDisappear: (() -> Void)?
    
    init() {
        let nibName = String(describing: Self.self)
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showRetryButton()
    }
    
    private func setupSubviews() {
        view.backgroundColor = AppStyle.Color.F2
        iconImageView.image = UIImage(named: "explosion")
        
        titleLabel.font = AppStyle.Font.get(.medium, size: .header)
        titleLabel.numberOfLines = 0
        titleLabel.text = "Ha ocurrido un error"
        
        subtitleLabel.font = AppStyle.Font.get(.regular, size: .body)
        subtitleLabel.textColor = AppStyle.Color.N4
        subtitleLabel.text = "Parece que algo explotó mientras revisababamos tu solicitud. Puedes volver a intentar en un par de segundos."
        subtitleLabel.numberOfLines = 0
        
        retryButton.setTitle("Volver a intentar", for: .normal)
        retryButton.type = .quiet
        retryButton.alpha = 0
    }
    
    private func showRetryButton() {
        UIView.animate(withDuration: 0.3, delay: 1.5, options: []) { [weak self] in
            guard let self = self else { return }
            self.retryButton.alpha = 1
        }
    }
    
    @IBAction func retryOnTap(_ sender: PYButton) {
        dismiss(animated: false) { [weak self] in
            guard let self = self else { return }
            self.onDisappear?()
        }
    }
}
