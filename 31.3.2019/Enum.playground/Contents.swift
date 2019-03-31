import UIKit

enum Platform{
    case iOS
    case tvOS
    case watchOS, macOS
    
    static func supportedPlatforms() -> [Platform]{
        return [.iOS, .watchOS]
    }
}

Platform.supportedPlatforms()

let p1 : Platform = Platform.tvOS
let p2 : Platform = .iOS
let p3 = Platform.macOS

var p4 : Platform = .iOS
p4 = .macOS

func getCurrentPlatform() -> Platform?{
    return nil
}



enum Day : Int{
    case sunday = 1
    case monday, tuseday, wednesday
    case thurdsay /*= 10*/, friday, saturday
    
    func nextDay() -> Day{
        return Day(rawValue: self.rawValue + 1) ?? .sunday
    }
    
    var prevDay : Day{
        get{
            return Day(rawValue: self.rawValue - 1) ?? .saturday
        }
    }
}

Day.sunday.nextDay().prevDay

let d1 = Day.sunday
let d1Raw = d1.rawValue

let d2 : Day? = Day(rawValue: 0) //nil


func getNextDay(_ day : Day) -> Day{
    return Day(rawValue: day.rawValue + 1) ?? .sunday
    /*
    if let nextDay = Day(rawValue: day.rawValue + 1){
        return nextDay
    } else {
        return .sunday
    }*/
}

print(getNextDay(.saturday))


enum GetDataResult{
    case failure(error : Error)
    case success(data : [Any])
}

enum LoginMethod{
    case email(email : String, password : String)
    case phone(phone : String, otpCode : String)
    case anonymus
}

func login(with method : LoginMethod){
    switch method {
    case .email(let email, let password):
        
    default:
        <#code#>
    }
}

let method = LoginMethod.email(email: "a@a.com", password: "123456")












