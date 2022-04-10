//
//  SceneDelegate.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Emogger
import SkeletonView
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.shadowImage = UIImage()
        let navBarButtonAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        navBarButtonAppearance.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 0), NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        
        window?.rootViewController = navigationController
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: AppStyle.Font.get(.medium, size: .secondTitle),
            NSAttributedString.Key.foregroundColor: AppStyle.Color.N1
        ]
        if #available(iOS 15, *) {
            UINavigationBar.appearance().isTranslucent = true
        } else {
            UINavigationBar.appearance().isTranslucent = false
        }
        UINavigationBar.appearance().tintColor = AppStyle.Color.N1
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().backgroundColor = AppStyle.Color.F2
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "back")
        
        UIApplication.shared.statusBarStyle = .darkContent
        
        let module = MainModule.setup(with: navigationController)
        module.show()
        
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        Emogger.shared.log("scene did disconnect", level: .event)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        Emogger.shared.log("scene did become active", level: .event)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        Emogger.shared.log("scene will resign active", level: .event)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        Emogger.shared.log("scene will enter foreground", level: .event)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        Emogger.shared.log("scene did enter background", level: .event)
    }
}

