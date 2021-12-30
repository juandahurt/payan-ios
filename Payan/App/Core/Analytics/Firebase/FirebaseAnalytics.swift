//
//  FirebaseAnalytics.swift
//  Payan
//
//  Created by juandahurt on 30/12/21.
//

import FirebaseCore
import FirebaseAnalytics
import Foundation

class FirebaseAnalytics: AnalyticsEngine {
    var name: String = "Firebase"
    
    func start() {
        FirebaseApp.configure()
    }
    
    func logEvent(_ event: AnalyticsEvent) {
        Analytics.logEvent(event.name, parameters: event.params)
    }
}
