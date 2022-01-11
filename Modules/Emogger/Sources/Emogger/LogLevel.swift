//
//  File.swift
//  
//
//  Created by juandahurt on 10/01/22.
//

import Foundation

public struct LogLevel: Equatable {
    var rawValue: Int
    var emoji: String
    
    public static let debug = LogLevel(rawValue: 0, emoji: "🐛")
    public static let warning = LogLevel(rawValue: 1, emoji: "⚠️")
    public static let info = LogLevel(rawValue: 2, emoji: "💬")
    public static let network = LogLevel(rawValue: 3, emoji: "🌐")
    public static let event = LogLevel(rawValue: 4, emoji: "📲")
    
    public static let all: [LogLevel] = [
        .debug,
        .warning,
        .info,
        .network,
        .event
    ]
}
