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
