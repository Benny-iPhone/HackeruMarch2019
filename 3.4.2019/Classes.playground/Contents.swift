import UIKit

class Person{
    let id : String // = ""
    var name : String // = ""
    //let birthDate : Date// = Date()
    private(set) var birthDate : Date
 
    var age : Int{
        get{
            let calendar = Calendar(identifier: .gregorian)
            let thisYear = calendar.component(.year, from: Date())
            let bdYear = calendar.component(.year, from: birthDate)
            
            return thisYear - bdYear
        }
    }
    
    init(id : String){
        self.id = id
        self.name = ""
        self.birthDate = Date(timeIntervalSince1970: 0)
    }
    
    func walk(){
        let secondsInDay : TimeInterval = 86_400
        birthDate.addTimeInterval(365 * secondsInDay)
    }
}

let myBaby = Person(id: "1234")
myBaby.name = "Zalman"
myBaby.walk()
myBaby.walk()
myBaby.age

//p.id = "3"

class Collage{
    
}

class Student : Person{
    //var collage : Collage?
    var collage : Collage
    
    override convenience init(id: String) {
        self.init(id: id, collage: Collage())
    }
    
    init(id : String, collage : Collage){
        self.collage = collage
        super.init(id: id)
    }
    
    override func walk() {
        super.walk()
    }
    
}

let s = Student(id: "12345")



class Dog{
    let name : String
    
    init(name : String){
        self.name = name
    }
}

let d1 = Dog(name: "Dudu")
let d2 = Dog(name: "Roger")
let d3 = Dog(name: "Foo")

var arr = [d2,d1,d3]
arr.sort { (d1, d2) -> Bool in
    return d1.name < d2.name
}

arr.sort { $0.name < $1.name }

arr















