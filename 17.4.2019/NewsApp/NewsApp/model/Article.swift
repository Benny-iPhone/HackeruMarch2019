//
//  Article.swift
//  NewsApp
//
//  Created by hackeru on 17/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

extension NewsAPI{
    
    struct ArticleResult : Codable {
        enum Status : String, Codable{
            case ok = "ok"
            case error = "error"
        }
        
        let status : Status
        let totalResults : Int
        let articles : [Article]
    }
    
    struct Article : Codable{
        let title : String
        let description : String
        let url : String
        let urlToImage : String
    }
    
}
