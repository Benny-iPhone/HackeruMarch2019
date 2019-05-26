//
//  ViewController.swift
//  ImageFromURL
//
//  Created by hackeru on 26/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func loadImage(with url : URL)
    {
        //create http request
        let request = URLRequest(url: url)
        //..
        
        //Send Request
        URLSession.shared.dataTask(with: request) { [weak self](data, response, error) in
            //handle data result
            guard let strongSelf = self ,
                let data = data,
                let image = UIImage(data: data) else{
                    return
            }
            
            //Display image on itself
            DispatchQueue.main.async {
                strongSelf.image = image
            }
        }.resume()
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func loadImageAction(_ sender: UIButton) {
        
        let urlString = "https://www.diygenius.com/wp-content/uploads/2015/06/steve-jobs-his-best-advice-759x500.jpg"
        guard let url = URL(string: urlString) else {
            print("invalid url")
            return
        }
        
        imageView.image = nil
        //asyncLoad(with: url)
        imageView.loadImage(with: url)
    }
    
    
    //better than not good, still not good enough
    private func asyncLoad(with url : URL){
        
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else{
                print("load data from url failed")
                return
            }
            
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
        
    }
    
    //not good
    private func syncOnMainThread(with url : URL){
        guard let data = try? Data(contentsOf: url) else{
            print("load data from url failed")
            return
        }
        
        let image = UIImage(data: data)
        imageView.image = image

    }
    
}

