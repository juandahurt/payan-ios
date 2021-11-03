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
        
        output.checkLatestVersion()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startJumpAnimation()
    }
    
    // MARK: - Animations
    private func startJumpAnimation() {
        imageConstraint.constant = imageOffset
        UIView.animate(withDuration: jumpAnimationDuration, delay: 0, options: [.autoreverse, .curveEaseOut, .repeat], animations: { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        })
    }
}
