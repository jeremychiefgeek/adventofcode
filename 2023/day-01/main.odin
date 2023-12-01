package dayone;

import "core:fmt";
import "core:os";
import "core:strings";
import "core:unicode"
import "core:reflect"

filepath := "inputdata.txt";
main :: proc() {
    data, ok := os.read_entire_file(filepath, context.allocator);
    if !ok {
        // could not read file
        fmt.println("File not readable");
        return;
    }
    defer delete(data, context.allocator);

    iteratableData := string(data);
    num1: int = 0
    num2: int = 0
    isInt: bool = false
    procInt: int = 0
    for line in strings.split_lines_iterator(&iteratableData) {
        num1 = 0
        num2 = 0
        // process lines
        //fmt.println(len(line));
        // Iterate through a string. (for variable: character, variable: index in string) 
        fmt.print(line)
        fmt.print(": ")
        for lineChar, index in line {
            if unicode.is_number(lineChar) {
                //fmt.print(lineChar, ' ')
                if num1 == 0 {
                    num1 = cast(int)lineChar
                } else {
                    num2 = cast(int)lineChar
                }
            }
        }

        fmt.print(num1 + num2, '\n')
    }
}
