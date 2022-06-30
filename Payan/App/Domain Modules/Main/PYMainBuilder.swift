//
//  PYMainBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 18/06/22.
//

import Foundation
import UIKit
import SwiftUI
import Purace

final class PYMainBuilder {
    func getViewController() -> UIViewController {
        let controller = UITabBarController()
        
        let feedViewController = UIHostingController(rootView: PYFeedModule.build())
        let feedIcon = UIImage(named: "home")
        feedViewController.tabBarItem.selectedImage = feedIcon
        feedViewController.tabBarItem.image = feedIcon
        
        let menuViewController = PYMenuBuilder().getViewController()
        let menuIcon = UIImage(named: "menu")
        menuViewController.tabBarItem.selectedImage = menuIcon
        menuViewController.tabBarItem.image = menuIcon
        
        controller.viewControllers = [
            feedViewController,
            menuViewController
        ]
        return controller
    }
}
