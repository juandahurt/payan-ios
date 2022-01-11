public struct Emogger {
    private let levels: [LogLevel]
    private(set) var numberOfLogs = 0
    
    public init(levels: [LogLevel]) throws {
        guard !levels.isEmpty else {
            throw EmoggerError.emptyLevels
        }
        
        self.levels = levels
    }
    
    public mutating func log(_ message: String, level: LogLevel) {
        guard isLevelEnabled(level) else {
            return
        }
        
        print("\(level.emoji) \(message)")
        numberOfLogs += 1
    }
    
    private func isLevelEnabled(_ level: LogLevel) -> Bool {
        levels.contains(level)
    }
}
