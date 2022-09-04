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
    
    func logEvent(name: String, params: [String : Any]?) {
        Analytics.logEvent(name, parameters: params)
    }
    
    func trackView(path: String, params: [String : Any]?) {
        var parameters = params
        if parameters != nil {
            parameters?[AnalyticsParameterScreenName] = path
        } else {
            parameters = [
                AnalyticsParameterScreenName: path
            ]
        }
        Analytics.logEvent(AnalyticsEventScreenView, parameters: parameters)
    }
}
