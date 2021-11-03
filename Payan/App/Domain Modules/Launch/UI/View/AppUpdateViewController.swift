//
//  AppUpdateBottomSheet.swift
//  Payan
//
//  Created by juandahurt on 24/10/21.
//

import UIKit

class AppUpdateViewController: UIViewController {

    init() {
        super.init(nibName: String(describing: AppUpdateViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}


// MARK: UIBottomSheetDataSource
extension AppUpdateViewController: UIBottomSheetDataSource {
    func embededView() -> UIView {
        view
    }
}
