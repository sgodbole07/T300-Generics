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
