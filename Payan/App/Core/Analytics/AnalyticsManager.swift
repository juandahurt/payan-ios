//
//  AnalyticsManager.swift
//  Payan
//
//  Created by juandahurt on 30/12/21.
//

import Foundation

final class AnalyticsManager {
    static let shared = AnalyticsManager()
    private var engines: [AnalyticsEngine] = []

    func registerEngine(_ engine: AnalyticsEngine) {
        engines.append(engine)
    }
    
    func logEvent(name: String, params: [String: Any]? = nil) {
        guard !engines.isEmpty else {
            print("You're trying to log \(name) event, but no engines have been registered!")
            return
        }
        for engine in engines {
            engine.logEvent(name: name, params: params)
        }
    }
    
    func trackView(path: String, params: [String: Any]? = nil) {
        guard !engines.isEmpty else {
            print("You're trying to track \(path), but no engines have been registered!")
            return
        }
        for engine in engines {
            engine.trackView(path: path, params: params)
        }
    }
}
