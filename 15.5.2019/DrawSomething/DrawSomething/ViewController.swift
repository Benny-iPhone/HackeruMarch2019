//
//  ViewController.swift
//  DrawSomething
//
//  Created by hackeru on 15/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var stepperValueLabel: UILabel!
    @IBOutlet weak var drawView: DrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func clearAction(_ sender: Any) {
        drawView.clear()
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
        let image = self.drawView.asImage()
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        
        drawView.pencilSize = CGFloat(sender.value)
        stepperValueLabel.text = String(format: "%.0f", sender.value)
        
    }
    
    @IBAction func colorSegmentedControlAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            drawView.pencilColor = .black
        case 1:
            drawView.pencilColor = .red
        case 2:
            drawView.pencilColor = .blue
        case 3:
            drawView.pencilColor = .green
        default:
            break
        }
        
    }
}

