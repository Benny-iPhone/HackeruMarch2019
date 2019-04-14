//
//  FirstViewController.swift
//  TwoViewControllers
//
//  Created by hackeru on 14/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    /*
    func showSecondVC(){
        let secondVC = SecondViewController()
        _ = secondVC.view //crate view
        secondVC.textField.text = label.text
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let secondVC = segue.destination as? SecondViewController{
            secondVC.text = label.text
            secondVC.delegate = self
            //secondVC.textField.text = label.text => crash, textField is nil
        }
        
    }
    
}

extension FirstViewController : SecondViewControllerDelegate{
    func secondViewController(_ controller: SecondViewController, didSelectText text: String?) {
        label.text = text
    }
    
}
