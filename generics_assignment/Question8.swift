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
