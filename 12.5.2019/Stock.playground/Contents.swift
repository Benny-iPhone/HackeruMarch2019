import UIKit

func solution(_ arr : [Int]) -> Int{
    var minPrice = Int.max
    var maxRev = 0
    
    for obj in arr{
        maxRev = max(maxRev,obj - minPrice)
        minPrice = min(obj,minPrice)
    }
    
    return maxRev
    
    /*
    var revs : [Int] = []
    
    for i in 0..<arr.count{
        var rev = 0
        for j in i..<arr.count{
            rev = max(rev, arr[j] - arr[i])
        }
        
        revs += [rev]
    }
    
    var maxRev = 0
    for obj in revs{
        maxRev = max(maxRev, obj)
    }
    
    
    return maxRev
 */
}

solution([40])
solution([40,35,40,20,50,70,100,10])
solution([])
solution([1,1,1,1,1,1])
