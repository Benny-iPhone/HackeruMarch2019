//
//  NewsAPI.swift
//  NewsApp
//
//  Created by hackeru on 17/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import Alamofire
//typealias JSON = [String:Any]

struct NewsAPI{
    
    enum Endpoint : String{
        case topHeadlines = "/v2/top-headlines"
        case everything = "/v2/everything"
    }
    
    private var baseURL : String{
        get{
            return "https://newsapi.org"
        }
    }
    
    private var apiKey : String{
        get{
            return "35c33e32ae0a44c4a43049823b2b7dcb"
        }
    }
    
    typealias ArticlesCallback = (_ data : ArticleResult?, _ error : Error?) -> Void
    func fetchArticles(from endpoint : Endpoint,
                       with params : [String:Any],
                       callback : @escaping ArticlesCallback){
        
        let url = self.baseURL + endpoint.rawValue
        var params = params
        params["apiKey"] = self.apiKey

        self.fetchData(from: url, params: params) { (data, error) in
            guard let data = data else{
                callback(nil,error)
                return
            }
            
            do{
                let result = try JSONDecoder().decode(ArticleResult.self, from: data)
                callback(result,nil)
            } catch {
                callback(nil,error)
            }
        }
    }
    
    //call to server with url and parameters, get back (async) data
    //this is a good place to take of http header fields, data encryption / decryption
    private func fetchData(from url : String,
                           params : [String:Any],
                           callback : @escaping (Data?,Error?)->Void)
    {
        Alamofire.request(url, method: .get, parameters: params).responseData { (result) in
            callback(result.value,result.error)
        }
    }
    
}
