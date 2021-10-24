//
//  LaunchViewController.swift
//  Payan
//
//  Created by juandahurt on 23/10/21.
//

import UIKit

class LaunchViewController: UIViewController {
    @IBOutlet weak var imageConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - UI Constants
    private let jumpAnimationDuration = 0.5
    private let fadeAnimationDuration = 0.5
    private let imageOffset: CGFloat = -35
    private let scale: CGFloat = 10
    
    // MARK: - Attributes
    private var output: LaunchViewOutput
    
    init(presenter: LaunchViewOutput) {
        output = presenter
        super.init(nibName: String(describing: LaunchViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Console.log("init(coder:) has not been implemented", level: .error)
        fatalError()
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Check app version
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startJumpAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.hideImage { _ in
                self.output.showHomeModule()
            }
        }
    }
    
    // MARK: - Animations
    private func startJumpAnimation() {
        imageConstraint.constant = imageOffset
        UIView.animate(withDuration: jumpAnimationDuration, delay: 0, options: [.autoreverse, .curveEaseOut, .repeat], animations: { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        })
    }
    
    private func hideImage(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: fadeAnimationDuration, delay: 0, options: [.curveEaseIn], animations: { [weak self] in
            guard let self = self else { return }
            self.imageView.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
            self.imageView.alpha = 0
        }, completion: completion)
    }
}
