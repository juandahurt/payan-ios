//
//  LaunchViewController.swift
//  Payan
//
//  Created by juandahurt on 23/10/21.
//

import Emogger
import RxSwift
import UIKit

class LaunchViewController: UIViewController {
    @IBOutlet weak var imageConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var factTitleLabel: UILabel! {
        didSet {
            factTitleLabel.textColor = .black
            factTitleLabel.font = AppStyle.Font.get(.semiBold, size: .subtitle)
            factTitleLabel.text = "Dato curioso"
            factTitleLabel.alpha = 0
        }
    }
    @IBOutlet weak var factLabel: UILabel! {
        didSet {
            factLabel.numberOfLines = 0
            factLabel.font = AppStyle.Font.get(.regular, size: .body)
            factLabel.textColor = .black.withAlphaComponent(0.7)
            factLabel.text = ""
            factLabel.alpha = 0
        }
    }
    
    // MARK: - UI Constants
    private let jumpAnimationDuration = 0.5
    private let fadeAnimationDuration = 0.5
    private let imageOffset: CGFloat = -35
    private let scale: CGFloat = 10
    
    // MARK: - Attributes
    private var input: LaunchViewInput
    private var output: LaunchViewOutput
    private var disposeBag = DisposeBag()
    
    init(presenter: LaunchViewOutput & LaunchViewInput) {
        input = presenter
        output = presenter
        super.init(nibName: String(describing: LaunchViewController.self), bundle: nil)
    }
    
    deinit {
        Emogger.shared.log("\(String(describing: Self.self)) is being deallocated", level: .debug)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rxBind()
        output.getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startJumpAnimation()
    }
    
    private func rxBind() {
        input.randomFact.drive(onNext: { [weak self] fact in
            guard let self = self else {
                return
            }
            
            self.factLabel.text = fact.description
            self.showFactLabel()
        }).disposed(by: disposeBag)
    }
}

// MARK: - Animations
extension LaunchViewController {
    private func startJumpAnimation() {
        imageConstraint.constant = imageOffset
        UIView.animate(withDuration: jumpAnimationDuration, delay: 0, options: [.autoreverse, .curveEaseOut, .repeat], animations: { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        })
    }
    
    private func showFactLabel() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.layoutSubviews], animations: { [weak self] in
            guard let self = self else { return }
            
            self.factTitleLabel.alpha = 1
            self.factLabel.alpha = 1
        })
    }
}
