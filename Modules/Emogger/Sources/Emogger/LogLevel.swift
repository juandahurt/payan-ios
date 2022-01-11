//
//  File.swift
//  
//
//  Created by juandahurt on 10/01/22.
//

import Foundation

public struct LogLevel {
    var emoji: String
    
    public static let debug = LogLevel(emoji: "🐛")
    public static let warning = LogLevel(emoji: "⚠️")
    public static let info = LogLevel(emoji: "💬")
    public static let network = LogLevel(emoji: "🌐")
    public static let event = LogLevel(emoji: "📲")
    
    public static let all: [LogLevel] = [
        .debug,
        .warning,
        .info,
        .network,
        .event
    ]
}
