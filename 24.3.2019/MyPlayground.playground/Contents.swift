import UIKit
/*
var str = "Hello, playground"

var i : Double = 5
i += 1
i = 1.95
let j = 8
//j -= 1
//let n1 = Int(i)
let result = Int(i) + j

let n2 : Int8 = 5 // -128...127

var n3 : UInt8 = 0 // 0...255
//n3 = -1

let myRand : UInt32 = arc4random() //0..<2^32

let numBetweenOneToTen = Int((myRand % 10) + 1)

let segmentedControl = UISegmentedControl()
segmentedControl.selectedSegmentIndex = numBetweenOneToTen
*/

//for i in 1..<10{
//
//}

for j in stride(from: 10, to: 1, by: -2){
    print(j)
}

/*
 for (var i = 0; i <= number; i += 1){
 //..do whatever
 }
 */

func count7Boom(_ number : Int) -> Int{

    var counter = 0
    
    for i in 0...number{
        if i % 7 == 0{
            counter += 1
            continue //next iteration
        }
        
        //check digits
        if i % 10 == 7 || //unit digit
            i / 10 % 10 == 7 ||//tens digit
            i / 100 == 7{ //hundreds digits
            counter += 1
        }
    }
    
    return counter
}

count7Boom(100)


















