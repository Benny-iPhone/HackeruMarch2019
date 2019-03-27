import UIKit

let val = true
if val || false{
    //always true
}

let isOdd = arc4random() % 2 != 0

if val && isOdd{
    print("if isOdd is true")
} else {
    print("if isOdd is false")
}

var a = 1 //0...001
var b = 2 //0...010
a | b     //0...011

a = 8 // 1000
b = 9 // 1001

a & b // 1000

let num = 14
let binaryString = String(num, radix: 2)

String(255, radix: 16)

let bleValue = 116
String(bleValue,radix: 2)
let fifthBit : Int = Int(pow(Double(2), 4))
String(fifthBit,radix: 2)

// 1110100
// 0010000

let isLedOn = bleValue & fifthBit != 0



















