//
//  MainViewController.swift
//  GesturesProject
//
//  Created by hackeru on 12/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    /*
     //computed way
    var childTabBarVC : UITabBarController?{
        get{
            return children.first{ $0 is UITabBarController} as? UITabBarController
            //return children.compactMap{ $0 as? UITabBarController}.first
        }
    }
 */
    
    //refrence
    weak var childTabBarVC : UITabBarController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UITabBarController{
            self.childTabBarVC = vc
        }
    }
    //MARK: - Actions
    
    @IBAction func rightAction(_ sender: Any) {
        //-1
        guard let childTabBarVC = self.childTabBarVC else{ return }
        
        print(#function)
        prevVC(childTabBarVC)
        
    }
    
    @IBAction func leftAction(_ sender: Any) {
        guard let childTabBarVC = self.childTabBarVC else{ return }
        //+1
        print(#function)
        nextVC(childTabBarVC)
    }
    
    func nextVC(_ controller : UITabBarController){
        let count = controller.viewControllers?.count ?? 0
        guard count > 0 else{ return }
        controller.selectedIndex = (controller.selectedIndex + 1) % count
    }
    
    func prevVC(_ controller : UITabBarController){
        let count = controller.viewControllers?.count ?? 0
        guard count > 0 else{ return }
        if controller.selectedIndex == 0{
            controller.selectedIndex = count - 1
        } else {
            controller.selectedIndex = (controller.selectedIndex - 1) % count
        }
    }

   
}
