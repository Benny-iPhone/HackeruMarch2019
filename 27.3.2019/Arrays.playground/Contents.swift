import UIKit

let arr1 = [1,2,3]
let arr2 : [Int] = [1,2,3]
let arr3 : Array<Int> = [1,2,3]

var emptyArray1 : [Int] = []
var emptyArray2 = [Int]()
var emptyArray3 = Array<Int>()

let arr : [Any] = [1,2.4,"hello world",arr1,UILabel()]
let firstNum = arr[0] as! Int //casting

var stringsArray = ["1","2","3","a","5"]
//stringsArray.compactMap(<#T##transform: (String) throws -> ElementOfResult?##(String) throws -> ElementOfResult?#>)
let intOfstringsArray = stringsArray.compactMap{ Int($0) }
intOfstringsArray

// add objects

var myArray : [Int] = [1,2,3]
myArray.append(4)
myArray.insert(0, at: 0)
myArray[1] = -1

if myArray.count >= 50{
    myArray.insert(50, at: 50)
}

myArray.first
myArray.last

// remove objects

let removedValue = myArray.remove(at: 2)
myArray

// concat arrays

myArray += [7,8,9]
myArray += [10]

var person = ["Mr.","Bar"]
let textField = UITextField()
textField.text = "Shimon"
if let text = textField.text{
    person += [text]
}
person.joined(separator: " ")

// sub array
myArray
let mySubArray = myArray[1...3]

myArray[1...3] = [1,2,3]
myArray
myArray[0...4] = [-7]
myArray

// iterate

for val in myArray{
  
}

for i in 0..<myArray.count{
    let val = myArray[i]
}

let stringsArray2 : [String] = ["a","b"]
for (index,value) in stringsArray2.enumerated(){
    print("index \(index): " + value)
}

//Write a function that receive an array of integers and returns the max value


func findMaxValue(in array : [Int]) -> Int{
    
    var big = array[0]
    
    for value in array{
        big = max(big, value)
//        if value > big{
//            big = value
//        }
    }
    
    return big
    
}

findMaxValue(in: [0,9,-1,-5])

// filter

var numbersArray = [10,20,19,32]

func myFilterFunc(_ n : Int) -> Bool{
    return n % 10 == 0
}

numbersArray.filter(myFilterFunc)
numbersArray.filter { (n) -> Bool in
    return n % 10 == 0
}


numbersArray.filter {
    return $0 % 10 == 0 //instead of using 'n' lets refer to the value as $0, meaning, the first 0-th argument
}

numbersArray.filter { $0 % 10 == 0 }


numbersArray.sort {
    return $0 < $1 //first argument is $0, second argument is $1, sort array by <
}

numbersArray.sort(by: >)

// set

let s1 : Set<String> = ["1","2","2","3"]
s1

let mySetArray = [1,1,1,1,2,2]
let s2 = Set(mySetArray)
Array(s2)

Array(Set(mySetArray))



















