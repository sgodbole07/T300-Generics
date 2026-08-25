
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
