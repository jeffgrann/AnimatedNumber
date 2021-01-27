import XCTest
@testable import AnimatedNumber

final class AnimatedNumberTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AnimatedNumber().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
