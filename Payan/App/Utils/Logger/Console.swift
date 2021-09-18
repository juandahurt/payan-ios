//
//  AppLogger.swift
//  Payan
//
//  Created by juandahurt on 18/09/21.
//

import Foundation
import Willow

private class EmojiModifier: LogModifier {
    func modifyMessage(_ message: String, with logLevel: LogLevel) -> String {
        switch logLevel {
        case .debug:
            return "🐛 [DEBUG]: \(message)"
        case .event:
            return "📱 [EVENT]: \(message)"
        case .error:
            return "❌ [ERROR]: \(message)"
        case .info:
            return "💬 [INFO]: \(message)"
        case .warn:
            return "⚠️ [WARN]: \(message)"
        default:
            return message
        }
    }
}

class Console {
    static private var _logger: Logger?
    static private var logger: Logger {
        if _logger == nil {
            let writer = ConsoleWriter(modifiers: [EmojiModifier(), TimestampModifier()])
            _logger = Logger(logLevels: [.all], writers: [writer])
        }
        return _logger!
    }
    
    static func log(_ message: String, level: LogLevel) {
        switch level {
        case .debug:
            logger.debugMessage(message)
            break
        case .event:
            logger.eventMessage(message)
            break
        case .error:
            logger.errorMessage(message)
            break
        case .info:
            logger.infoMessage(message)
            break
        case .warn:
            logger.warnMessage(message)
            break
        default:
            break
        }
    }
}
