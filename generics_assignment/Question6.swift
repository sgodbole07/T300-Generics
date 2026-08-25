//6. Type Constraints via where Clauses
//6.1 Write a generic function that checks whether an array contains a specific element. Use a
//where clause to constrain the element type to Equatable.
 
func isPresent<T>(_ array: [T], _ target: T) -> Bool where T: Equatable {
    for element in array {
        if element == target {
            return true
        }
    }
    return false
}

//6.2 Write a generic binary search function that returns the index of a target value in a sorted
//array, or nil if not found. Use a where clause to constrain the element type to Comparable.


func binarySearch<T>( array: [T], _ target: T) -> Int? where T: Comparable {
    var low = 0;
    var high = array.count - 1
    
    while low <= high {
        let mid = low + (high - low) / 2
        let value = array[mid]

        if value == target {
            return mid
        } else if value < target {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return nil
}


let sorted = [1, 3, 5, 7, 9, 11, 13]

print(binarySearch(array: sorted, 7) ?? -1)
print(binarySearch(array: sorted, 90) ?? -1)

