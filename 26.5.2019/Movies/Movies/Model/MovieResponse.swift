//
//  MovieResponse.swift
//  Movies
//
//  Created by hackeru on 26/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

struct MovieResponse : Codable{
    struct Movie : Codable{
        let title : String
        let poster_path : String
    }
    
    let results : [Movie]
}
