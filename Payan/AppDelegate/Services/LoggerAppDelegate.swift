//
//  LoggerAppDelegate.swift
//  Payan
//
//  Created by juandahurt on 12/01/22.
//

import Foundation
import UIKit
import Emogger

class LoggerAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do {
            Emogger.shared = try Emogger(levels: LogLevel.all)
        } catch {
            fatalError("Emogger couldn't be initiated!")
        }
        
        return true
    }
}


extension Emogger {
    static var shared: Emogger!
}
