//1. Generic Classes
//1.1 Implement a generic Pair class that can hold two values of any types. Add methods to set
//and retrieve both values.


class Pair <First, Second> {
    
    private var first: First
    private var second: Second
    
    init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }
    
    func setFirstValue(_ value: First) {
        first = value
    }
    
    func setSecondValue(_ value: Second) {
        second = value
    }
    
    func getFirstValue() -> First {
        return first
    }
    func getSecondValue() -> Second {
        return second
    }
}

let pair1 = Pair(32, "string")
//print(pair1.second)

let firstValue = pair1.getFirstValue()
let secondValue = pair1.getSecondValue()
print(firstValue)
print(secondValue)


pair1.setFirstValue(110)
pair1.setSecondValue("secondstring")
print(pair1.getFirstValue())
print(pair1.getSecondValue())


//1.2 Create a generic Cache<Key, Value> class with a maximum capacity. Implement an
//eviction strategy, either LRU (least recently used) or LFU (least frequently used).


final class Cache<Key: Hashable, Value> {

    private let capacity: Int
    private var storage: [Key: Value] = [:]
    private var frequency: [Key: Int] = [:]

    init(capacity: Int) {
        self.capacity = capacity
    }

    func set(_ key: Key, _ value: Value) {
        if storage[key] == nil, storage.count >= capacity {
            if let lfuKey = frequency.min(by: { $0.value < $1.value })?.key {
                storage.removeValue(forKey: lfuKey)
                frequency.removeValue(forKey: lfuKey)
            }
        }
        storage[key] = value
        frequency[key, default: 0] += 1
    }

    func get(_ key: Key) -> Value? {
        guard let value = storage[key] else { return nil }
        frequency[key, default: 0] += 1
        return value
    }

    var count: Int { storage.count }
}

let cache = Cache<String, Int>(capacity: 2)
cache.set("a", 1)
cache.set("b", 2)

_ = cache.get("a")
// I tried to access a again so its frewuency count increases
cache.set("c", 3)

print(cache.count)
// Third entry was made but cache still shows count two that means we evicted the LFU entry
print(cache.get("b") ?? -1)
// we fetched entry for b but it was nil hence printed -1, because the b was LFU so it got removed

let cacheForInteger = Cache<Int, Int>(capacity: 2)

cacheForInteger.set(1, 100)
cacheForInteger.set(2, 200)
_ = cacheForInteger.get(1)

cacheForInteger.set(3, 300)

print(cacheForInteger.get(2) ?? -1)
// This ^^ got evicted
print(cacheForInteger.get(1) ?? -1)
print(cacheForInteger.get(3) ?? -1)



//2. Generic Structs
//2.1 Design a generic Point<T> struct where T: FloatingPoint, representing a 2D point with x
//and y coordinates. Add a method that calculates the Euclidean distance between two points.

struct Point<T: FloatingPoint>  {
    var x_co: T
    var y_co: T
    
    init(_ x_co: T, _ y_co: T) {
        self.x_co = x_co
        self.y_co = y_co
    }
    
    func calculateDistance(from point: Point<T>) -> T where T: FloatingPoint {
        let diff_x = x_co - point.x_co
        let diff_y = y_co - point.y_co
        return (diff_x * diff_x + diff_y * diff_y).squareRoot()
    }
}


let point1 = Point(20.12, 13.0)

print(point1.calculateDistance(from: Point(25.9, 6.5)))


//2.2 Implement a generic LinkedList<Element> struct that supports inserting, deleting, and
//searching for elements. Searching should work for any element type.
struct LinkedList<Element> {
    
    private class Node {
        var value: Element
        var next: Node?
        init(_ value: Element, next: Node? = nil) {
            self.value = value
            self.next = next
        }
    }
    
    private var head: Node?
    
    var count: Int = 0
    
    mutating func insert(at index: Int, value: Element) {
        let newNode = Node(value)
        if index == 0 {
            newNode.next = head
            head = newNode
            count+=1
            return
        }
        
        var current = head
        for _ in 0..<(index - 1) {
            current = current?.next
        }
        newNode.next = current?.next
        current?.next = newNode
        count += 1
    }
    
    mutating func insertAtEnd(_ value: Element) {
        let newNode = Node(value)
        guard let h = head else {
            head = newNode
            count += 1
            return
        }
        var current  = h
        while let next = current.next {
            current = next
        }
        current.next = newNode
        count += 1
    }
    
    
    mutating func delete(at index: Int) {
        guard index >= 0 && index < count, let h = head else {
            print("invalid index or nil list")
            return
        }
        
        if index == 0 {
            head = h.next
            count -= 1
            print("removed the \(h.value) node")
        }
        var current = h
        for _ in 0..<(index-1) {
            guard let next = current.next else { return }
            current = next
        }
        guard let target = current.next else { return }
        current.next = target.next
        count -= 1
        return
    }
    
    
    func printList() {
        var current = head
        while let node = current {
            print("node value: \(node.value)")
            current = node.next
        }
    }
    
}


extension LinkedList where Element: Equatable {
    func findIndex(of value: Element) -> Int? {
        var current = head
        var index = 0
        while let node = current {
            if node.value == value {
                return index
            }
            current = node.next
            index += 1
        }
        return nil
    }
}


var list = LinkedList<Int>()
list.insertAtEnd(100)
list.insertAtEnd(200)
list.insertAtEnd(300)

list.insert(at: 2, value: 500)

print(list.count)
list.printList()
list.delete(at: 1)
print("after deletion")
list.printList()


var list_string = LinkedList<String>()
list_string.insertAtEnd("string1")
list_string.insertAtEnd("string2")
list_string.insertAtEnd("string3")


list_string.printList()

list_string.insert(at: 2, value: "string10")

list_string.printList()


list_string.delete(at: 1)
print("after deletion")
list_string.printList()



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



//4. Generic Enums
//4.1 Define your own generic MyOptional<Wrapped> enum with two cases: some(Wrapped)
//and none. Add a map method that transforms the wrapped value if present.

//I dont know in which data type to transform so assuming the transformation logic handles that and transforms it into Int

enum MyOptional<Wrapped> {
    case some(Wrapped)
    case none

    func map<NewWrapped>(_ transformingClosure: (Wrapped) -> NewWrapped) -> MyOptional<NewWrapped> {
        switch self {
        case .none:
            return .none
        case .some(let value):
            return .some(transformingClosure(value))
        }
    }
}

//4.2 Define your own generic MyResult<Success, Failure: Error> enum with
//success(Success) and failure(Failure) cases. Add a map method that transforms the
//success value.

// This code wont compile bacuse question did not mention in what data type to transform,

enum MyResult<Success, Failure: Error> {
    
    case success(Success)
    case failure(Failure)
    
    
    func map<NewSuccess>(_ transformingClosure: (Success) -> NewSuccess) -> MyResult<NewSuccess, Failure> {
        switch self {
        case .failure(let error):
            return .failure(error)
        case .success(let value):
            return .success(transformingClosure(value))
        }
    }
}

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


//7. Protocols with Associated Types
//7.1 Define a protocol Displayable with an associated type Value and a method display(_
//value: Value). Implement it for at least two concrete types.


protocol Displayable {
    associatedtype Value
    func display(_ value: Value)
}

struct IntDisplayer: Displayable {
    func display(_ value: Int) {
        print("Integer value: \(value)")
    }
}

struct StringDisplayer: Displayable {
    func display(_ value: String) {
        print("String value: \"\(value)\"")
    }
}

 let intDisplayer = IntDisplayer()
 intDisplayer.display(42)

let stringDisplayer = StringDisplayer()
stringDisplayer.display("this is a display string")


//7.2 Define a protocol Container with an associated type Item. It should support adding an item,
//removing an item at an index, retrieving an item via subscript, and reporting its count. Implement
//it for at least one concrete type.

protocol Container<Item> {
    associatedtype Item

    mutating func add(_ item: Item)
    mutating func remove(at index: Int) -> Item
    subscript(index: Int) -> Item { get }
    var count: Int { get }
}

struct ArrayContainer<Item>: Container {
    private var items: [Item] = []

    mutating func add(_ item: Item) {
        items.append(item)
    }

    mutating func remove(at index: Int) -> Item {
        items.remove(at: index)
    }

    subscript(index: Int) -> Item {
        items[index]
    }

    var count: Int {
        items.count
    }
}


 var container = ArrayContainer<String>()
 container.add("abc")
 container.add("pqr")
 container.add("xyz")
 print(container.count)
 print(container[1])
 container.remove(at: 0)
 print(container.count)
 print(container[0])


//8. Modern Swift Generics
//8.1 Write a function makeSequence(from:) that returns numbers from 1 to n. The return type
//must use some Sequence<Int>, not a concrete type like [Int] or Range<Int>.

func makeSequence(from n: Int) -> some Sequence<Int> {
    1...n
}


 for value in makeSequence(from: 5) {
     print(value)
 }


//8.2 Model a small zoo. Define an Animal protocol with a describe() method. Create three
//conforming types (Dog, Cat, Bird). Store all three in a single array using [any Animal], and
//loop over them printing each animal's description.

protocol Animal {
    func describe() -> String
    
}

struct Dog: Animal {
    let name: String
    func describe() -> String {
        "\(name) is a Dog and barks like bhow"
    }
}

struct Cat: Animal {
    let name: String
    func describe() -> String {
        "\(name) is a Cat and says Meow"
    }
}

struct Bird: Animal {
    let name: String
    func describe() -> String {
        "\(name) is a Bird and says Cheev"
    }
}


let zoo: [any Animal] = [
    Dog(name: "Dog1"),
    Cat(name: "Cat1"),
    Bird(name: "Bird1")
]

for animal in zoo {
    print(animal.describe())
}

//8.3. Write two versions of a function that checks whether a passed-in value equals a stored
//constant: One using some Equatable in the parameter. One using any Equatable.


class StoredValue {
    let storedNumber: Int

    init(storedNumber: Int) {
        self.storedNumber = storedNumber
    }

    // We can use `some` when we want compile-time safty.
    func matchesSome(input: some Equatable) -> Bool {
        guard let inp = input as? Int else { return false }
        return storedNumber == inp
    }

    // We can use `any` when we need to accept values of different different data types
    func matchesAny(input: any Equatable) -> Bool {
        guard let inp = input as? Int else { return false }
        return storedNumber == inp
    }
}


//8.4. Take your Container protocol from question 7.2 and mark Item as a primary associated
//type. Then write a function sum(_ c: some Container<Int>) -> Int, with no where
//clause.


func sum(_ c: some Container<Int>) -> Int {
    var total = 0
    for i in 0..<c.count {
        total += c[i]
    }
    return total
}


 var intContainer = ArrayContainer<Int>()
 intContainer.add(10)
 intContainer.add(20)
 intContainer.add(30)
 print(sum(intContainer))
