//
//  AppDelegate.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var services: [UIApplicationDelegate] = [
        PYNetworkingAppDelegate(),
        FirebaseAppDelegate(),
        AnalyticsAppDelegate()
    ]
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        for service in services {
            _ = service.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        
        return true
    }
}

