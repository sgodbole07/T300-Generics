//5. Type Constraints
//5.1 Write a generic function that finds the maximum value in an array. Constrain the type
//parameter to Comparable so it works for any comparable type (Int, Double, String, custom
//types).


func findMax<T: Comparable> (_ array: [T]) -> T {
    var maxi = array[0]
    for element in array {
        if element > maxi {
            maxi = element
        }
    }
    return maxi
}

print(findMax([1,2,3,4,5,90,6]))
print(findMax([1.8,2.09,3,4.78,5,90.9,607.77]))
print(findMax(["a", "b", "g"]))


//5.2 Write a generic function that computes the dot product of two arrays. Constrain the type
//parameter to Numeric. The function should crash cleanly (with precondition) if the arrays are
//different lengths.


func dotProduct<T: Numeric> (_ a: [T], _ b: [T]) -> T {
    precondition(a.count == b.count, "both array should be of equal length")
    
    var result: T
    result = a[0] * b[0]
    
    for i in 1..<a.count {
        result = result + (a[i] * b[i])
    }
    return result
    
}

print(dotProduct([1, 2, 3], [4, 5, 6]))

print(dotProduct([1.90, 2.56, 3.89], [4.2, 5.5, 6.4]))

