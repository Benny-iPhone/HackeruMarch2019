//
//  WelcomeViewController.swift
//  MultipleTargets
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

extension UIColor{
    class var appTintColor : UIColor{
        return AppModel.model.appUIConfigs.tintColor
    }
}

class WelcomeViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        button.tintColor = .appTintColor
        view.backgroundColor = AppModel.model.appUIConfigs.bgColor
        
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        //passengerSegue
        //taxiSegue
        
        let identifier = AppModel.model.appConfigs.mainSegueId
        
        self.performSegue(withIdentifier: identifier, sender: sender)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
