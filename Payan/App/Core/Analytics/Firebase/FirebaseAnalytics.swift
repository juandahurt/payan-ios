//
//  FirebaseAnalytics.swift
//  Payan
//
//  Created by juandahurt on 30/12/21.
//

import FirebaseAnalytics
import Foundation

class FirebaseAnalytics: AnalyticsEngine {
    var name: String = "Firebase"
    
    func logEvent(_ event: AnalyticsEvent) {
        Analytics.logEvent(event.name, parameters: event.params)
    }
}
