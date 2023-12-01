package dayone;

import "core:fmt";
import "core:os";
import "core:strings";
import "core:unicode"
import "core:strconv"
import "core:unicode/utf8"

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
    num1: rune = 0
    num2: rune = 0
    isInt: bool = false
    procInt: int = 0
    result: int = 0
    for line in strings.split_lines_iterator(&iteratableData) {
        num1 = 0
        num2 = 0
        // process lines
        //fmt.println(len(line));
        // Iterate through a string. (for variable: character, variable: index in string) 
        //fmt.print(line)
        //fmt.print(": ")
        for lineChar, index in line {
            if unicode.is_number(lineChar) {
                bytes, length := utf8.encode_rune(lineChar)
                //fmt.print(lineChar, ' ')
                if num1 == 0 {
                    num1 = lineChar//strconv.atoi(string(bytes[:length]))
                } else {
                    num2 = lineChar //strconv.atoi(string(bytes[:length]))
                }
            }
        }

        if num2 == 0 {
            num2 = num1
        }

        concat := strings.concatenate({utf8.runes_to_string({num1}), utf8.runes_to_string({num2})})
        fmt.println(concat)
        result += strconv.atoi(concat)
    }

    fmt.println(result)
}
