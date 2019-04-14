//
//  ColorPickerViewController.swift
//  ColorPickerProject
//
//  Created by hackeru on 14/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import ChromaColorPicker

@objc protocol ColorPickerViewControllerDelegate{
    
    func colorPickerVC(_ controller : ColorPickerViewController, didSelectColor color : UIColor)
    
}

class ColorPickerViewController: UIViewController {
    
    var delegate : ColorPickerViewControllerDelegate?

    @IBOutlet weak var colorPicker: ChromaColorPicker!
    
    class func createVC() -> ColorPickerViewController{
        let mainStoryboard = UIStoryboard(name: "Main", bundle: .main)
        return mainStoryboard.instantiateViewController(withIdentifier: "ColorPickerViewController") as! ColorPickerViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func colorPickerValueChanged(_ sender: ChromaColorPicker) {
        
        delegate?.colorPickerVC(self, didSelectColor: sender.currentColor)
        
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
