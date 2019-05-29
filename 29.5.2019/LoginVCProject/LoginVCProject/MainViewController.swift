//
//  MainViewController.swift
//  LoginVCProject
//
//  Created by hackeru on 29/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func logoutAction(){
        var store = DataStore()
        store.authToken = nil
        Router.shared.determineRoot()
    }
}
