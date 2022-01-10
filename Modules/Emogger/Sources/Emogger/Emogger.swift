public struct Emogger {
    public init(events: [LogEvent]) throws {
        guard !events.isEmpty else {
            throw EmoggerError.emptyEvents
        }
    }
}
