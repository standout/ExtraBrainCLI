import XCTest
@testable import ExtraBrain

final class StringExtensionsTests: XCTestCase {

    func testTimeInterval() {
        XCTAssertEqual(TimeInterval(3600), "1h".timeInterval)
        XCTAssertEqual(TimeInterval(1800), "30m".timeInterval)
        XCTAssertEqual(TimeInterval(5400), "1h30m".timeInterval)
    }

    static var allTests = [
        ("testTimeInterval", testTimeInterval),
    ]
}
