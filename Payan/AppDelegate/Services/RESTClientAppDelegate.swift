//
//  RESTClientAppDelegate.swift
//  Payan
//
//  Created by juandahurt on 31/12/21.
//

import Foundation
import UIKit

class RESTClientAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        RESTClient.provideBaseUrl(Environment.current.apiUrl)
        
        return true
    }
}
