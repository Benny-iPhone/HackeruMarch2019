//
//  Tweet.swift
//  CellFromNibFile
//
//  Created by hackeru on 10/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

struct Tweet{
    let content : String
    let author : String
    
    static var demo : [Tweet]{
        
        return [
            Tweet(content: "sdgdsfgdfg xgg dfg dsfg dsf dsg dsfg dsfg dsfg dsfg dsf dsfg dsfg ", author: "Shaked"),
            Tweet(content: "dfg dsfg dsfg dsfg ", author: "Benny"),
            Tweet(content: "sdfg", author: "Guy"),
            Tweet(content: "1684351😁", author: "Erez")

        ]
        
    }
}
