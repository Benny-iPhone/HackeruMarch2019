//
//  Colors.swift
//  ColorsPickerView
//
//  Created by hackeru on 31/03/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

enum Colors : Int{
    case red, yellow, green , black, blue, purple, orange, white, brown
    
    static let count = 9
    
    var displayName : String{
        get{
            switch self{
            case .red: return "אדום"
            case .yellow: return "צהוב"
            case .green: return "ירוק"
            case .black: return "שחור"
            case .blue: return "כחול"
            case .purple: return "סגול"
            case .orange: return "כתום"
            case .white: return "לבן"
            case .brown: return "חום"
            }
        }
    }
    
    var uiColor : UIColor{
        get{
            switch self{
            case .red: return .red
            case .yellow: return .yellow
            case .green: return .green
            case .black: return .black
            case .blue: return .blue
            case .purple: return .purple
            case .orange: return .orange
            case .white: return .white
            case .brown: return .brown
            }
        }
    }
}
