import XCTest
@testable import Swilby

final class SwilbyTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Swilby().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
