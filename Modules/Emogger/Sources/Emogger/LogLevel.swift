//
//  File.swift
//  
//
//  Created by juandahurt on 10/01/22.
//

import Foundation

public struct LogLevel {
    var emoji: String
    
    public static let debug = LogLevel(emoji: "")
    
    public static let all: [LogLevel] = [
        .debug
    ]
}
