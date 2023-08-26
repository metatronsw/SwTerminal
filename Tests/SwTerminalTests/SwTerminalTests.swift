import XCTest
@testable import SwTerminal

final class SwTerminalTests: XCTestCase {
    
	func testExample() throws {

		 printty(.colorBg(.red), .colorFg(.green), "fasza", .fontReset)
		 
		 let (row,col) = terminalSize()
		 printty(.clearScreen)
		 printty(.cursor(row: row, col: col-3), "End")
		
		
		print("Tic-Tac".termBlink)
    }
}
