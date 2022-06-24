//
//  SceneDelegate.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import UIKit
import Purace

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.backgroundColor = .white
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        UITabBar.appearance().backgroundImage = nil
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = .white
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(PuraceStyle.Color.G1)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(PuraceStyle.Color.G8)
        
        window?.rootViewController = navigationController
        
        
        PYRoutingManager.provideNavigationController(navigationController)
        let modules: [PYModule] = [
            PYCollectionModule(),
            PYPlaceModule(),
            PYHeroModule()
        ]
        modules.forEach { PYRoutingManager.shared.addModule($0) }
        navigationController.pushViewController(PYMainModule.getViewController(), animated: false)
        PuraceManager.shared.configure()
        
        window?.makeKeyAndVisible()
    }
}

