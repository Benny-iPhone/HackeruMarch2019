//
//  ViewController.swift
//  ThreadSafety
//
//  Created by Benny Davidovitz on 24/07/2019.
//  Copyright © 2019 HackerU. All rights reserved.
//

import UIKit

class SharedData{
    
    static let singleton = SharedData()
    
    private static var shared : SharedData? = nil
    private static let lock = NSLock()
    private let lock = NSLock()
    var num = 3
    var arr : [Int] = []
    
    static func getShared() -> SharedData
    {

        lock.lock()
        if shared == nil{
            shared = SharedData()
        }
        lock.unlock()
        
        return shared!
    }
    
    func writeData(){
        lock.lock()
        //write some data
        sleep(2)
        lock.unlock()
    }
    
    func sayHello(){
        print("hello")
    }
    
    init() {
        print("SharedData init")
        sleep(1)
    }
    
}

class MyClass{
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //DispatchQueue.global() => concurrent
        DispatchQueue.global().async {
            SharedData.getShared().sayHello()
        }
        
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.1) {
            SharedData.getShared().sayHello()
        }
        
        func dataJob(with callback : @escaping ()->Void){
            var num = 3 //stack, value
            let c = MyClass() //heap, memory
        }
        
        func uiJob(){
        }

        
        // Do any additional setup after loading the view.
        DispatchQueue.global().async {
            dataJob {
                DispatchQueue.main.async {
                    uiJob()
                }
            }
        }
    }
    

    

}

