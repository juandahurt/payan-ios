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
        let baseUrl: String
        
        switch AppConfig.environment {
        case .dev:
            baseUrl = "https://payan-dev.herokuapp.com/"
            break
        case .prod:
            baseUrl = "https://payan-prod.herokuapp.com/"
        }
        RESTClient.provideBaseUrl(baseUrl)
        
        return true
    }
}
