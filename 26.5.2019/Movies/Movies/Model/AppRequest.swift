//
//  AppRequest.swift
//  Movies
//
//  Created by hackeru on 26/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
//SDWebImage
struct AppRequest{
    
    enum Endpoint{
        case discoverMovie
        case discoverTV
        
        var url : String{
            get{
                switch self {
                case .discoverMovie: return baseURL + "/discover/movie"
                case .discoverTV: return baseURL + "/discover/tv"
                }
            }
        }
        
        private var baseURL : String{
            get{
                return "https://api.themoviedb.org/3"
            }
        }
        
        var defaultParams : [String:Any]{
            get{
                return ["api_key":"e898f9a386bfdb67610421b879360e02"]
            }
        }
    }
    
    let endpoint : Endpoint
    var params : [String:Any]
    
    init(endpoint : Endpoint){
        self.endpoint = endpoint
        self.params = endpoint.defaultParams
    }
    
    func sendRequest(with callback : @escaping (Data?,Error?)->Void)
    {
        var url = endpoint.url
        let queryString = params.compactMap{ "\($0.key)=\($0.value)"}.joined(separator: "&")
        
        url = url + "?" + queryString
        
        var urlRequest = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod = "GET"
        //urlRequest.httpMethod = "POST"
        //for post request, query string should be in body
        //urlRequest.httpBody =
        //urlRequest.setValue("", forHTTPHeaderField: "")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            callback(data,error)
        }.resume()
    }
    
}

