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
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = UIColor(PuraceStyle.Color.G1)
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(PuraceStyle.Color.G1)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(PuraceStyle.Color.G8)
        
        window?.rootViewController = navigationController
        
        
        PYRoutingManager.provideNavigationController(navigationController)
        let routeHandlers: [PYRouteHandler] = [
            PYMainRouteHandler(),
            PYHeroRouteHandler(),
            PYCollectionRouteHandler(),
            PYPlaceRouteHandler()
        ]
        routeHandlers.forEach { PYRoutingManager.shared.addRouteHandler(routeHandler: $0) }
        navigationController.pushViewController(PYMainBuilder().getViewController(), animated: false)
        PuraceManager.shared.configure()
        
        window?.makeKeyAndVisible()
    }
}

