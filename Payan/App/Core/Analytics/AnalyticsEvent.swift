//
//  AnalyticsEvent.swift
//  Payan
//
//  Created by juandahurt on 30/12/21.
//

import Foundation

protocol AnalyticsEvent {
    var name: String { get }
    var params: [String: Any]? { get }
}
