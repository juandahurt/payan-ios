public struct Emogger {
    private static let instance = Emogger()
    
    private init() {}
    
    public static func provideEvents(_ events: [LogEvent]) throws {
        guard !events.isEmpty else {
            throw EmoggerError.emptyEvents
        }
    }
}
