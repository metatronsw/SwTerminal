#if canImport(Darwin)
import Darwin
#else
import Glibc
#endif


/// Printing ANSI escape characters to terminal
public func printty(_ codes: String...) {
	codes.forEach { fputs($0, stdout) }
	fflush(stdout)
}


/// Get the terminal actual size
public func terminalSize() -> (rows: Int, cols: Int) {
	var w = winsize()
	guard ioctl(STDOUT_FILENO, TIOCGWINSZ, &w) != 0 else { return (0,0) }
	return (rows: Int(w.ws_row), cols: Int(w.ws_col))
}


@discardableResult
public func getKeyPress () -> Int {
	var key: Int = 0
	var c: cc_t = 0
	var cct = (c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c) // Set of 20 Special Characters
	var oldt: termios = termios(c_iflag: 0, c_oflag: 0, c_cflag: 0, c_lflag: 0, c_cc: cct, c_ispeed: 0, c_ospeed: 0)
	
	tcgetattr(STDIN_FILENO, &oldt) // 1473
	var newt = oldt
	newt.c_lflag = 1217  // Reset ICANON and Echo off
	tcsetattr( STDIN_FILENO, TCSANOW, &newt)
	key = Int(getchar())  // works like "getch()"
	tcsetattr( STDIN_FILENO, TCSANOW, &oldt)
	return key
}
