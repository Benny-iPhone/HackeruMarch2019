import UIKit

func firstAttempt(){
    let urlString = "https://www.mysite.com/data?query=משה"
    
    let url = URL(string: urlString) //nil
    print(url != nil)
}

firstAttempt()

func secondAtttempt(){
    let baseURL = "https://www.mysite.com/data"
    guard var comps = URLComponents(string: baseURL) else{
        print("failed")
        return
    }
    
    comps.queryItems = [
        URLQueryItem(name: "query", value: "משה")
    ]
    
    let url = comps.url
    print(url != nil)
}

secondAtttempt()

let problematicString = "משה 😀?&"

problematicString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
