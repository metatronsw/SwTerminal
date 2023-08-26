#if canImport(Darwin)
import Darwin
#else
import Glibc
#endif



public enum RawModeError: Error {
	case notATerminal
	case failedToGetTerminalSetting
	case failedToSetTerminalSetting
}


public func terminalRawModeRun(_ task: @escaping () throws -> Void) throws {
	
	guard isatty(STDIN_FILENO) != 0 else { throw RawModeError.notATerminal }

	
	var originalTermSetting = termios()
	
	guard tcgetattr(STDIN_FILENO, &originalTermSetting) >= 0 else {
		throw RawModeError.failedToGetTerminalSetting
	}
	
	
	var raw = originalTermSetting
	raw.c_iflag &= ~(UInt(BRKINT) | UInt(ICRNL) | UInt(INPCK) | UInt(ISTRIP) | UInt(IXON))
	raw.c_oflag &= ~(UInt(OPOST))
	raw.c_cflag |= UInt(CS8)
	raw.c_lflag &= ~(UInt(ECHO) | UInt(ICANON) | UInt(IEXTEN) | UInt(ISIG))
	raw.c_cc.16 = 0
	raw.c_cc.17 = 1
	
	guard tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw) >= 0 else {
		throw RawModeError.failedToSetTerminalSetting
	}
	
	defer {
		tcsetattr(STDIN_FILENO, TCSAFLUSH, &originalTermSetting)
	}
	
	print("\u{1b}[2J")
	
	try task()
}


// Example usage: run a loop until 'q' is pressed
/*
let q = Character("q").asciiValue!
try terminalRawModeRun {
	while true {
		var char: UInt8 = 0
		read(STDIN_FILENO, &char, 1)
		if char == q {
			exit(0)
		}
	}
}
*/

