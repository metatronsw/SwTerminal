
extension String {
	
	/// ANSI terminal colors
	public enum TTYColor: Int, CaseIterable {
		case black = 30, red, green, yellow, blue, magenta, cyan, white
		case lightBlack = 90, lightRed, lightGreen, lightYellow, lightBlue, lightMagenta, lightCyan, lightWhite
		
		static var random: Self {
			return Self.allCases.randomElement()!
		}
	}
	
	
	/// Ansi escape char

	public static let esc = "\u{001B}["
	
	
	// Cursor Control
	
	public static func cursor(row: Int, col: Int) -> String { "\(esc)\(row);\(col)H" }
	public static func cursorUp(_ count: Int = 1) -> String { "\(esc)\(count)A" }
	public static func cursorDown(_ count: Int = 1) -> String { "\(esc)\(count)B" }
	public static func cursorRight(_ count: Int = 1) -> String { "\(esc)\(count)C" }
	public static func cursorLeft(_ count: Int = 1) -> String { "\(esc)\(count)D" }
	public static func lineNext(_ count: Int = 1) -> String { "\(esc)\(count)E" }
	public static func linePrev(_ count: Int = 1) -> String { "\(esc)\(count)F" }
	public static func column(_ column: Int) -> String { "\(esc)\(column)G" }
	
	public static let cursorPosSave = "\(esc)s"
	public static let cursorPosLoad = "\(esc)u"
	public static let cursorHide = "\(esc)?25l"
	public static let cursorShow = "\(esc)?25h"
	
	
	// Font decoration
	
	public static func colorFg(_ color: TTYColor) -> String { "\(esc)\(color.rawValue)m" }
	public static func colorFg8Bit(_ color: Int) -> String { "\(esc)38;5;\(color)m" }
	public static func colorFgRGB(red: Int, green: Int, blue: Int) -> String { "\(esc)38;2;\(red);\(green);\(blue)m" }
	public static func colorBg(_ color: TTYColor) -> String { "\(esc)\(color.rawValue + 10)m" }
	public static func colorBg8Bit(_ color: Int) -> String { "\(esc)48;5;\(color)m" }
	public static func colorBgRGB(red: Int, green: Int, blue: Int) -> String { "\(esc)48;2;\(red);\(green);\(blue)m" }
	
	public static let fontReset = "\(esc)0m"
	public static let fontResetBGColor = "\(esc)39m"
	public static let fontBold = "\(esc)1m"
	public static let fontItalic = "\(esc)3m"
	public static let fontUnderline = "\(esc)4m"
	public static let fontBlink = "\(esc)5m"
	
	
	// Clear screen
	
	public static let clearLine = "\(esc)2K"
	public static let clearLineToEnd = "\(esc)0K"
	public static let clearLineToBegin = "\(esc)1K"
	
	public static let clearScreen = "\(esc)2J"
	public static let clearScreenToEnd = "\(esc)0J"
	public static let clearScreenToBegin = "\(esc)1J"
	
	
	// Scroll screen
	
	public static func screenUp(_ count: Int = 1) -> String { "\(esc)\(count)S" }
	public static func screenDown(_ count: Int = 1) -> String { "\(esc)\(count)T" }
	
	
}




public extension String {

	/// Set text bold on terminal.
	public var termBold: String { .fontBold + self + .fontReset }

	/// Set text italic on terminal.
	public var termItalic: String { .fontItalic + self + .fontReset }

	/// Set text underline on terminal.
	public var termUnderline: String { .fontUnderline + self + .fontReset }

	/// Set text blink on terminal.
	public var termBlink: String { .fontBlink + self + .fontReset }

	/// Set text color on terminal.
	public func termTextColor(_ color: TTYColor) -> String { .colorFg(color) + self + .fontReset }

	/// Set background color on terminal.
	public func termBGColor(_ color: TTYColor) -> String { .colorBg(color) + self + .fontReset }

}


