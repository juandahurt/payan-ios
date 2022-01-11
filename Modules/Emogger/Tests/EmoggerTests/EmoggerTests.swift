import XCTest
@testable import Emogger

final class EmoggerTests: XCTestCase {

    func test_throw_empty_levels() throws {
        do {
            _ = try Emogger(levels: [])
        } catch EmoggerError.emptyLevels {
            return
        } catch {
            XCTFail("Wrong error thrown")
        }
    }
}
