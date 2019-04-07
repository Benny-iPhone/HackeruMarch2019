import UIKit

struct Point : CustomStringConvertible{
    
    let x : Double
    let y : Double
    
    func distance(from point : Point) -> Double{
        
        return sqrt(pow(self.x - point.x, 2) + pow(self.y - point.y, 2))
        
    }
    
    var description: String{
        get{
            return "(\(x),\(y))"
        }
    }
    
}

let p1 = Point(x: 0, y: 0)
let p2 = Point(x: 3, y: 4)

p1.distance(from: p2)


class LoginLogic{
    
    struct SignUpData {
        let email : String
        let password : String
        let name : String
    }
    
    func signUp(with data : SignUpData){
        
    }
    
    /*
    func signUp(with email : String, password : String , nickname : String, facebookId : String, registerDate : Date){
        
    }*/
    
}


struct Car{
    let id : String
    var color : String //hex string i.e. 00ff00
    let year : Int
  
    mutating func paintAsTaxi(){
        self.color = "ffffff" //white
    }
}

func paintCarAsTaxi(_ car : Car) -> Car{
    var newCar = car
    newCar.color = "fff"
    
    return newCar
}

var c1 = Car(id: "12-123-12", color: "000000", year: 2016)
c1.color = "ff0000" //red
c1 = paintCarAsTaxi(c1)


var c2 = Car(id: "123123", color: "aabbcc", year: 2015)
c2.paintAsTaxi()

class MyClass{
    var val : String = ""
}

struct MyStruct{
    var val : String
}

var obj1 = MyClass()
obj1.val = "obj1Val"

var objArr : [MyClass] = [obj1,obj1]

var val1 = MyStruct(val: "val1Val")
var valsArr : [MyStruct] = [val1,val1]

objArr[1].val = "newVal"

objArr[0].val
obj1.val


valsArr[1].val = "newVal2"
valsArr[0].val
val1.val

valsArr[1].val

func doSomething( num : inout Int){
//    var num = num
    num = 4
}

var myNum = 3
//doSomething(num: myNum)
doSomething(num: &myNum)
myNum


struct AirPlane{
    
    var altitude : Double = 0
    
    static let maxAltitude : Double = 1_000
    
    static func isValid(airPlane : AirPlane) -> Bool{
        return airPlane.altitude <= self.maxAltitude
    }
    
}

var ap1 = AirPlane(altitude: 50)
var ap2 = ap1

ap2.altitude += 100
ap1.altitude

AirPlane.isValid(airPlane: ap2)

struct Sqaure{
    var side : Double
//    {
//        didSet{
//            area = pow(side, 2)
//        }
//    }
    var area : Double{
        get{
            return pow(side, 2)
        }
        set (newArea){
            side = sqrt(newArea) //use newValue if no name specified
        }
    }
//    {
//        didSet{
//            side = sqrt(area)
//        }
//    }
}

var r1 = Sqaure(side: 5)//, area: 25)
r1.area
r1.area = 36
r1.side
















