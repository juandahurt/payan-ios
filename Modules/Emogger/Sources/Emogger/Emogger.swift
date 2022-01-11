public struct Emogger {
    private let levels: [LogLevel]
    
    public init(levels: [LogLevel]) throws {
        guard !levels.isEmpty else {
            throw EmoggerError.emptyLevels
        }
        
        self.levels = levels
    }
    
    public func log(_ message: String, level: LogLevel) {
        print("\(level.emoji) \(message)")
    }
}
