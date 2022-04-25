//
//  NetworkingAppDelegate.swift
//  Payan
//
//  Created by Juan Hurtado on 25/04/22.
//

import Foundation
import UIKit

final class PYNetworkingAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        PYNetworkManager.provideBaseUrl("https://payan-dev.vercel.app")
        return true
    }
}
