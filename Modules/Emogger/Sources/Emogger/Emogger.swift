public struct Emogger {
    public init(levels: [LogLevel]) throws {
        guard !levels.isEmpty else {
            throw EmoggerError.emptyLevels
        }
    }
}
