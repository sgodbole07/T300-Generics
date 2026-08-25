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
