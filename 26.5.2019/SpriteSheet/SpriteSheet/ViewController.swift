//
//  ViewController.swift
//  SpriteSheet
//
//  Created by hackeru on 26/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView : UIImageView!
    var data : [[UIImage]] = []
    var index : Int = 0{
        didSet{
            guard index < data.count else { return }
            populateImageView(with: data[index])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        
        ImageParser(image: UIImage(named: "trump_run")!, rows: 4, columns: 6).parse { [weak self](result) in
            self?.data = result
            self?.index = 0
        }
        //data = ImageParser(image: UIImage(named: "trump_run")!, rows: 4, columns: 6).parse()
        
        //self.index = 0
        //populateImageView(with: data[0])
    }
    
    private func populateImageView(with images : [UIImage]){
        
        let wasAnimating = imageView.isAnimating
        
        imageView.image = images.first
        imageView.animationImages = images
        imageView.animationRepeatCount = 0 //infinite animation
        imageView.animationDuration = 0.5 //second
        
        if wasAnimating{
            imageView.startAnimating()
        }
    }
    
    @IBAction func toggleAnimation(){
        if imageView.isAnimating{
            imageView.stopAnimating()
        } else {
            imageView.startAnimating()
        }
    }
    
    @IBAction func nextAnimation(){
        if index + 1 >= data.count{
            self.index = 0
        } else {
            self.index += 1
        }
    }


}

