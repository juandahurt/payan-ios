//
//  AnalyticsEngine.swift
//  Payan
//
//  Created by juandahurt on 30/12/21.
//

import Foundation

protocol AnalyticsEngine: AnyObject {
    var name: String { get }
    func logEvent(_ event: AnalyticsEvent)
}
