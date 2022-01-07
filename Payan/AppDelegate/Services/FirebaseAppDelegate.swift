//
//  FirebaseAppDelegate.swift
//  Payan
//
//  Created by juandahurt on 31/12/21.
//

import FirebaseCore
import Foundation
import UIKit

class FirebaseAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
