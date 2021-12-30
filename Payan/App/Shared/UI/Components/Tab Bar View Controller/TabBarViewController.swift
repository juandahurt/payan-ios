//
//  TabbedBarViewController.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.barTintColor = .white
        tabBar.tintColor = AppStyle.Color.primary
        tabBar.backgroundColor = .white
    }
}
