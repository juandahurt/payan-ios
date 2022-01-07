//
//  AnalyticsAppDelegate.swift
//  Payan
//
//  Created by juandahurt on 31/12/21.
//

import Foundation
import UIKit

class AnalyticsAppDelegate: NSObject, UIApplicationDelegate {
    private let engines: [AnalyticsEngine] = [
        FirebaseAnalytics()
    ]
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        for engine in engines {
            AnalyticsManager.shared.registerEngine(engine)
        }
        
        return true
    }
}
