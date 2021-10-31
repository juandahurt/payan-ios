//
//  UIBottomSheet.swift
//  Payan
//
//  Created by juandahurt on 24/10/21.
//

import UIKit

class UIBottomSheet: UIViewController {
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - Private
    private var embededView: UIView
    
    // MARK: - Lyfecycle
    init(embededView: UIView) {
        self.embededView = embededView
        
        super.init(nibName: String(describing: UIBottomSheet.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Console.log("init(coder:) has not been implemented", level: .error)
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupEmbededView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showContainerFromBottom()
    }

    // MARK: - UI
    private func setupUI() {
        viewContainer.backgroundColor = Color.background
    }
    
    private func setupEmbededView() {
        embededView.frame = viewContainer.frame
        viewContainer.addSubview(embededView)
    }
    
    // MARK: - Animations
    private func showContainerFromBottom() {
        UIView.animate(withDuration: 0.35, delay: 0.2, options: [.curveEaseInOut]) { [weak self] in
            self?.bottomConstraint.constant = 0
            self?.view.layoutIfNeeded()
        }
    }
}
