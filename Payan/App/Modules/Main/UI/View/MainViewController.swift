//
//  MainViewController.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import UIKit

class MainViewController: TabBarViewController {
    var output: MainViewOutput
    
    init(presenter: MainViewOutput) {
        self.output = presenter
        super.init(nibName: String(describing: MainViewController.self), bundle: nil)
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        Console.log("init(coder:) has not been implemented", level: .error)
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            return output.shouldSelectTab(at: index)
        }
        return false
    }
}
