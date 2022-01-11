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
    
    func test_disabled_level() throws {
        do {
            var sut = try Emogger(levels: [.debug])
            sut.log("Invalid log!", level: .network)
            XCTAssertNotEqual(sut.numberOfLogs, 1)
        } catch {
            XCTFail("Test should not throw!")
        }
    }
    
    func test_enabled_level() throws {
        do {
            var sut = try Emogger(levels: [.debug])
            sut.log("Valid log!", level: .debug)
            sut.log("Valid log!", level: .debug)
            XCTAssertEqual(sut.numberOfLogs, 2)
        } catch {
            XCTFail("Test should not throw!")
        }
    }
}
