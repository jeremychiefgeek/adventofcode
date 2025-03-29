package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

main :: proc() {
	leftArr: [dynamic]int
	rightArr: [dynamic]int

	f, err := os.open("input.txt")
	if err != nil {
		// Handle Err
		fmt.println(err)
		return
	}
	// process file
	fmt.println("File Opened")
	data, ok := os.read_entire_file(f)
	if !ok {
		fmt.println("Read file unsuccessfully")
		return
	}

	fmt.println("Read file successfully")
	os.close(f)

	it := string(data)
	count := 0
	for line in strings.split_lines_iterator(&it) {
		// We now have the lines split and looping through
		// Now we need to split the lines into two lists or arrays
		count = 0
		for numberStr in strings.split(line, "   ") {
			if count == 0 {
				if n, ok := strconv.parse_int(numberStr); ok {
					append(&leftArr, n)
				}
			} else {
				if n, ok := strconv.parse_int(numberStr); ok {
					append(&rightArr, n)
				}
			}
			count += 1
		}
	}

	fmt.printfln("Left Array Legnth: %i", len(leftArr))
	fmt.printfln("Right Array Legnth: %i", len(rightArr))

	fmt.println("Processing Order for Left Array...")
	currentIndex: int
	currentValue: int

	// Loop through and order them smallest to largest.
	for n in leftArr {
		if n != currentValue {

		}
		currentValue = n
		currentIndex += 1
	}

	currentIndex = 0
	for n in rightArr {
		if n != currentValue {

		}
		currentValue = n
		currentIndex += 1
	}
}
