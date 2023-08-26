# The Swift Terminal extension

It's a simple and powerful addition to the String structure, making it easy to control the Terminal. You can color the letters, the background, move the cursor, clear the screen.

A collection of many useful functions you can use with the terminal.
It is important to note that the XCode console is not a real terminal, so it cannot display coloured letters or move the cursor. 

Usage: 

```Swift
printty(.colorBg(.red), .colorFg(.green), "Colored text", .fontReset)
```

```Swift
 let (row,col) = terminalSize()
 
 printty(.clearScreen)
 printty(.cursor(row: row, col: col-3), "End")
```


```Swift
print("Tic-Tac".termBlink)
```
