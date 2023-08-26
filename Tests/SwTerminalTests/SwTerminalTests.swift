import XCTest
@testable import SwTerminal

final class SwTerminalTests: XCTestCase {
    func testExample() throws {

		 printty(.colorBg(.red), .colorFg(.green), "fasza")
    }
}
