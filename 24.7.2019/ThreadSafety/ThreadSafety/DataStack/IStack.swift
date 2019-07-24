//
//  IStack.swift
//  ThreadSafety
//
//  Created by Benny Davidovitz on 24/07/2019.
//  Copyright © 2019 HackerU. All rights reserved.
//

import Foundation

protocol IStack {
    func add(obj : Any)
    func pop() -> Any?
    var first : Any? { get }
    var count : Int { get }
}

class ConcurrentStack : IStack{
    private var arr : [Any]
    private let queue : DispatchQueue
    
    init(){
        self.arr = []
        self.queue = DispatchQueue(label: UUID().uuidString, attributes: .concurrent)
    }
    
    /*
 
     queue: [A,B,C,D,E,F,G]
     D: -> Barrier
     
     t------->
     A.........A   |
       B....B      |
         C........C|
                   |D.......D|
                             |E...
                            |F..
 */
    func add(obj: Any) {
        queue.async(flags: .barrier) {
            self.arr.append(obj)
        }
    }
    
    func pop() -> Any? {
        return nil
    }
    
    //Reader - Can read multiple times at once
    
    var first: Any?{
        var result : Any?
        queue.sync {
            result = arr.first
        }
        return result
    }
    
    var count: Int{
        var result : Int = 0
        queue.sync {
            result = arr.count
        }
        return result
    }
    
}

class SerialStack : IStack{
    
    private var arr : [Any]
    private let queue : DispatchQueue
    
    init(){
        self.arr = []
        self.queue = DispatchQueue(label: UUID().uuidString) // => Serial
    }
    //Writers - Keep it safe
    
    func add(obj: Any) {
        queue.async {
            self.arr.append(obj)
        }
    }
    
    func pop() -> Any? {
        var result : Any?
        queue.sync {
            result = arr.popLast()
        }
        return result
    }
    
    //Reader - Make sure not while writing
    
    var first: Any?{
        var result : Any?
        queue.sync {
            result = arr.first
        }
        return result
    }
    
    var count: Int{
        var result : Int = 0
        queue.sync {
            result = arr.count
        }
        return result
    }
    
}
























