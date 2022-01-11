public struct Emogger {
    public init(levels: [LogLevel]) throws {
        guard !levels.isEmpty else {
            throw EmoggerError.emptyLevels
        }
    }
    
    public func log(_ message: String, level: LogLevel) {
        print("\(level.emoji) \(message)")
    }
}
