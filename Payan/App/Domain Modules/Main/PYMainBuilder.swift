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
        let worker = PYMainLocalWorker()
        let interactor = PYMainInteractor(worker: worker)
        let controller = UITabBarController()

        let feedViewController = PYFeedBuilder().build {
            controller.tabBar.isHidden = false
        }
        let feedIcon = UIImage(named: "home")
        feedViewController.tabBarItem.title = "Inicio"
        feedViewController.tabBarItem.selectedImage = feedIcon
        feedViewController.tabBarItem.image = feedIcon
        
        let mapViewController = PYMapBuilder().build()
        let mapIcon = UIImage(named: "map")
        mapViewController.tabBarItem.title = "Mapa"
        mapViewController.tabBarItem.selectedImage = mapIcon
        mapViewController.tabBarItem.image = mapIcon
        
        let menuViewController = PYMenuBuilder().build()
        let menuIcon = UIImage(named: "menu")
        menuViewController.tabBarItem.title = "Menú"
        menuViewController.tabBarItem.selectedImage = menuIcon
        menuViewController.tabBarItem.image = menuIcon
        
        controller.viewControllers = [
            feedViewController,
            mapViewController,
            menuViewController
        ]
//        controller.tabBar.isHidden = true
        
        if interactor.checkIfUserHasSeenOnboarding() {
            return controller
        } else {
            return PYOnbardingBuilder().build {
                interactor.saveUserSawOnboarding()
                PYRoutingManager.shared.push(controller)
                PYRoutingManager.shared.setViewControllers([controller])
            }
        }
    }
}
