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
        tabBar.tintColor = Color.primary
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        Utility.addShadow(to: tabBar, offset: CGSize(width: 0, height: -4))
    }
}
