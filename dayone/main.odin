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

	fmt.println("Processing Order for Left & Right Array...")

	leftArrSorted := sort(leftArr)
	rightArrSorted := sort(rightArr)

	if len(leftArrSorted) == len(rightArrSorted) {
		fmt.println("Finding the total distance between the left list and the right list...")
		totalDistance: int
		sum: int
		for i := 0; i < len(leftArrSorted); i += 1 {
			sum = 0
			// fmt.printfln("%i   %i", leftArrSorted[i], rightArrSorted[i])
			// totalDistance = totalDistance + (leftArrSorted[i] - rightArrSorted[i])
			sum = leftArrSorted[i] - rightArrSorted[i]
			totalDistance += abs(sum)
		}
		fmt.printfln("Total Distance: %i", totalDistance)
	} else {
		fmt.println("Sorting failed")
	}

}

duplicate_count :: proc(array: [dynamic]int) {

}

sort :: proc(array: [dynamic]int) -> [dynamic]int {
	currentValue: int
	position: int
	a := array

	// Loop through and order them smallest to largest.
	for i := 1; i < len(a); i += 1 {
		currentValue = a[i]
		position = i
		for position > 0 && a[position - 1] > currentValue {
			a[position] = a[position - 1]
			position -= 1
		}
		a[position] = currentValue
	}

	return a
}
