import UIKit

protocol MyProtocol{
    var displayString : String { get set }
    
    func doSomething()
    func getValue(by parameter : Int) -> Int
}

struct MyStruct : MyProtocol{
    var value : Int = 0
    var displayString: String = ""
    
    func doSomething() {
        print("doing something")
    }
    
    func getValue(by parameter: Int) -> Int {
        return parameter * 3
    }
    
}

var obj : MyProtocol = MyStruct()
obj.displayString = "hello"
obj.getValue(by: 3)


struct Car{
    let id : String
    var passengers : [IPassenger] = []
    var capacity : Int = 0
    
    static let maxCapacity = 5
    static let maxWeight : Double = 500
    
    let selfWeight : Double = 100
    var passengersWeight : Double{
        get{
            return passengers.reduce(0) { (sum, p) -> Double in
                return sum + p.weight
            }
            
            //return passengers.reduce(0) { $0 + $1.weight}
        }
    }
    
    var totalWeight : Double{
        get{
            return selfWeight + passengersWeight
        }
    }
    
    func canAdd(passenger : IPassenger) -> Bool{
        guard totalWeight + passenger.weight <= Car.maxWeight else { return false }
        guard capacity + passenger.capacity <= Car.maxCapacity else { return false }
        return true
    }
}

protocol IPassenger{
    
    var weight : Double { get }
    var capacity : Int { get }
    
    mutating func hopOn(car : Car) -> Bool
    //func drop(car : Car) -> Bool
    
}

struct Suitcase {
    var carId : String?
}

extension Suitcase : IPassenger{
    var weight: Double {
        get{
            return 20
        }
    }
    
    var capacity: Int {
        return 1
    }
    
    mutating func hopOn(car : Car) -> Bool{
        guard carId == nil else{
            return false
        }
        
        guard car.canAdd(passenger: self) else{
            return false
        }
        
        self.carId = car.id
        return true
    }
}
















