//
//  ImageParser.swift
//  SpriteSheet
//
//  Created by hackeru on 26/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

struct ImageParser{
    
    let image : UIImage
    let rows : Int
    let columns : Int
    
    typealias Callback = (_ result : [[UIImage]]) -> Void
    func parse(with callback : @escaping Callback)
    {
        
        var result = [[UIImage]](repeating: [UIImage](repeating: UIImage(), count: columns), count: rows)
        
        var rect = CGRect(x: 0,
                          y: 0,
                          width: image.size.width / CGFloat(columns),
                          height: image.size.height / CGFloat(rows))
        
        //perform parsing operation on background thread
        DispatchQueue.global().async {
            for i in 0..<self.rows{
                
                for j in 0..<self.columns{
                    
                    if let image = self.crop(rect: rect){
                        result[i][j] = image
                    }
                    //move 'cursor' to next column
                    rect.origin.x += rect.width
                    
                }
                
                //move 'cursor' to start on the next row
                rect.origin.x = 0
                rect.origin.y += rect.height
                
            }
            //back to main thread, instead of return statement
            DispatchQueue.main.async {
                callback(result)
            }
        }
        
        
        
        //return result
        
        //[Int](repeating: 0, count: 6)
    }
    
    private func crop(rect : CGRect) -> UIImage?
    {
        guard let cgImage = image.cgImage?.cropping(to: rect) else{ return nil}
        return UIImage(cgImage: cgImage)
    }
    
    
    
}
