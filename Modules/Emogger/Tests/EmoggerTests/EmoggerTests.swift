import XCTest
@testable import Emogger

final class EmoggerTests: XCTestCase {

    func test_throw_empty_events() throws {
        do {
            try Emogger.provideEvents([])
        } catch EmoggerError.emptyEvents {
            return
        } catch {
            XCTFail("Wrong error thrown")
        }
    }
}
