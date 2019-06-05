//
//  TabBarContainerViewController.swift
//  MilaSegmentedControl
//
//  Created by hackeru on 05/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class TabBarContainerViewController: UIViewController {

    weak var managedTabBarController : UITabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentedControlAction(_ sender : UISegmentedControl)
    {
        managedTabBarController?.selectedIndex = sender.selectedSegmentIndex
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? UITabBarController{
            self.managedTabBarController = nextVC
            nextVC.tabBar.isHidden = true
        }
    }

}
