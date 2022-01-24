//
//  AnalyticsManager.swift
//  Payan
//
//  Created by juandahurt on 30/12/21.
//

import Emogger
import Foundation

final class AnalyticsManager {
    static let shared = AnalyticsManager()
    private var engines: [AnalyticsEngine] = []

    func registerEngine(_ engine: AnalyticsEngine) {
        engines.append(engine)
    }
    
    func logEvent(_ event: AnalyticsEvent) {
        guard !engines.isEmpty else {
            Emogger.shared.log("You're trying to log \(event.name) event, but no engines have been registered!", level: .warning)
            return
        }
        
        Emogger.shared.log("Logging \(event.name) event", level: .info)
        for engine in engines {
            engine.logEvent(event)
        }
    }
}
