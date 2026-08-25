//3. Generic Functions
//3.1 Write a generic function printArray that takes an array of any type and prints each element.

func printArray<T> (_ array: [T]) {
    for element in array {
        print(element)
    }
}

printArray([1, 2, 3])

printArray(["abc", "pqr", "xyz"])


//3.2 Write a generic function mergeSort that sorts an array of any comparable type using the
//merge sort algorithm.

func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }

    let mid = array.count / 2
    let left = mergeSort(Array(array[..<mid]))
    let right = mergeSort(Array(array[mid...]))

    return mergeHelper(left, right)
}


private func mergeHelper<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
    var result: [T] = []

    var i = 0
    var j = 0
    while i < left.count && j < right.count {
        if left[i] <= right[j] {
            result.append(left[i])
            i += 1
        } else {
            result.append(right[j])
            j += 1
        }
    }
    result.append(contentsOf: left[i...])
    result.append(contentsOf: right[j...])

    return result
}

 print(mergeSort([5, 30, 8, 19, 4, 2]))
 print(mergeSort(["axz", "apq", "cdgh", "cayu"]))
