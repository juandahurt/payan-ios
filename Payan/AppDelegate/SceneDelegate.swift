//
//  SceneDelegate.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import UIKit

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
        let navBarButtonAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        navBarButtonAppearance.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 0), NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        window?.rootViewController = navigationController
        
        
        PYRoutingManager.provideNavigationController(navigationController)
        let modules: [PYModule] = [
            PYFeedModule(),
            PYCollectionModule()
        ]
        modules.forEach { PYRoutingManager.shared.addModule($0) }
        PYRoutingManager.shared.open(url: URL(string: "payan://feed")!)
        
        window?.makeKeyAndVisible()
    }
}

