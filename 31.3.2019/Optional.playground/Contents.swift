import UIKit

var str = "123"
var str1 : String? = "a"
str1 = nil

let arr = [1,2,3]

var intVal = Int(str)
intVal

let num = 4

let result : Int
if intVal != nil{
    result = intVal! + num
} else {
    result = 0 + num
}

intVal? += 2

(intVal ?? 0) + num

let textField = UITextField()

let valueFromTextField = Double(textField.text ?? "") ?? 0

if let text = textField.text, text.isEmpty == false, let intVal2 = Int(text){
    
} else {
    
}

/*
 Write an app with an UITextField
 indicate if the text is a valid email
 */
