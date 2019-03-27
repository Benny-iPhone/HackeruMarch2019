import UIKit

func sumDigits(_ num : Int) -> Int{
    var num = num //convert num from let to var
    var sum = 0
    
    while num != 0{
        sum += num % 10
        num /= 10
    }
    
    return sum
    
}

sumDigits(1230)
let point = CGPoint(x: 4, y: 5.2)
pow(2, 3)
/*
typealias 😎 = Int

func 😜😜😜😜() -> 😎{
    return 5
}

😜😜😜😜()

*/

func isPita(a : Double, b : Double, c : Double) -> Bool{
    return pow(a, 2) + pow(b, 2) == pow(c, 2)
}

isPita(a: 3, b: 4, c: 5)
isPita(a: 0, b: 0, c: 0)


let arr /*: [Int]*/ = [1,2,3,4,1,2,3]

/*
 000
 101
 
 001
 101
 
 100
 101
 
 001
 
 0^A = A
 a^X^X = a
 a^X^Y^X^Y = a
 0^A^X^X = A
 */


func findOdd(in array : [Int]) -> Int{
    var x = 0
    for n in array{
        x ^= n
    }
    
    return x
}

findOdd(in: arr)















