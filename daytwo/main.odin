package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

main :: proc() {
	safeCount: int
	fmt.println("Starting Day Two")
	inputData, ok := get_input_data()
	if ok {
		currentIterationArr: []string
		checkSolutionTwoArr: [dynamic]string
		isSafe: bool
		for line in inputData {
			currentIterationArr = strings.split(line, " ")
			lineIntArray := convert_to_int_array(currentIterationArr)
			isSafe = is_line_safe(lineIntArray)
			if isSafe {
				safeCount += 1
			} else {
				for i := 0; i < len(lineIntArray); i += 1 {
					testArr := convert_to_int_array(currentIterationArr, i, true)
					isSafe = is_line_safe(testArr)
					if isSafe {
						// fmt.printfln("%s is safe %b", line, isSafe)
						safeCount += 1
						break
					}
				}
			}
			// fmt.printfln("%s is safe %b", line, isSafe)
		}
		fmt.printfln("Safe Count: %i", safeCount)
	} else {
		fmt.println("The solution failed to run")
	}
}

is_line_safe :: proc(arr: [dynamic]int) -> bool {
	position: int
	direction: string
	for i := 0; i < len(arr); i += 1 {
		position = i
		for position > 0 {
			if arr[position - 1] > arr[position] {
				if direction == "" || direction == "increasing" {
					direction = "increasing"
					if abs(arr[position - 1] - arr[position]) > 3 ||
					   abs(arr[position - 1] - arr[position]) == 0 {
						return false
					}
				} else {
					return false
				}
			} else if arr[position - 1] < arr[position] {
				if direction == "increasing" {
					return false
				} else if direction == "" || direction == "decreasing" {
					if abs(arr[position - 1] - arr[position]) > 3 {
						return false
					}
				}
			} else {
				return false
			}
			position -= 1
		}
	}
	return true
}

convert_to_int_array :: proc(
	strArr: []string,
	index: int = 0,
	skipIndex: bool = false,
) -> [dynamic]int {
	intArr: [dynamic]int
	for str in strArr {
		if n, ok := strconv.parse_int(str); ok {
			append(&intArr, n)
		}
	}
	if skipIndex {
		ordered_remove(&intArr, index)
	}
	return intArr
}
get_input_data :: proc() -> ([dynamic]string, bool) {
	path := "input.txt"

	file, err := os.open(path)

	if err != nil {
		fmt.println(err)
		return nil, false
	}
	data, ok := os.read_entire_file(file)
	defer os.close(file)

	retArr: [dynamic]string
	iterator := string(data)
	for line in strings.split_lines_iterator(&iterator) {
		append(&retArr, line)
	}
	return retArr, true
}
