package dayone;

import "core:fmt";
import "core:os";
import "core:strings";

filepath := "inputdata.txt";
main :: proc() {
    data, ok := os.read_entire_file(filepath, context.allocator);
    if !ok {
        // could not read file
        fmt.println("File not readable");
        return;
    }
    defer delete(data, context.allocator);

    it := string(data);
    for line in strings.split_lines_iterator(&it) {
        // process lines
       fmt.println(line); 
    }
}
