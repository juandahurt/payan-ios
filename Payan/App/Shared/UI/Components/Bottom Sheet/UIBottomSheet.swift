//
//  UIBottomSheet.swift
//  Payan
//
//  Created by juandahurt on 24/10/21.
//

import UIKit

class UIBottomSheet: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    // MARK: - Public
    var dataSource: UIBottomSheetDataSource?
    
    // MARK: - Lyfecycle
    init() {
        super.init(nibName: String(describing: UIBottomSheet.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Console.log("init(coder:) has not been implemented", level: .error)
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showContainerFromBottom()
    }

    // MARK: - UI
    private func setupUI() {
        backgroundView.alpha = 0
        viewContainer.backgroundColor = AppStyle.Color.background
        if let embededView = dataSource?.embeddedView() {
            let window = UIApplication.shared.windows.first
            let bottomPadding = window?.safeAreaInsets.bottom ?? 0
            
            heightConstraint.constant = embededView.frame.height
            bottomConstraint.constant = -(heightConstraint.constant + bottomPadding)
            embededView.frame = CGRect(
                x: 0,
                y: 0,
                width: viewContainer.frame.width,
                height: viewContainer.frame.height
            )
            viewContainer.addSubview(embededView)
            view.layoutIfNeeded()
        }
    }
    
    // MARK: - Animations
    private func showContainerFromBottom() {
        UIView.animate(withDuration: 0.35, delay: 0, options: [.curveEaseInOut]) { [weak self] in
            self?.backgroundView.alpha = 0.7
            self?.bottomConstraint.constant = 0
            self?.view.layoutIfNeeded()
        }
    }
}


// MARK: - DataSource
protocol UIBottomSheetDataSource {
    func embeddedView() -> UIView
}
