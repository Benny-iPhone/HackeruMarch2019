//
//  AppStartViewController.swift
//  AnimationLottie
//
//  Created by hackeru on 17/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import Lottie

extension UIView{
    func embed(view : UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(view)
        
        [
            view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ].forEach{ $0.isActive = true }
    }
}

class AppStartViewController: UIViewController {

    @IBOutlet weak var animationContainerView: UIView!
    weak var animationView : AnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()

        loadInitialData()
        //loadAnimation(name: "water-loading")
        //loadAnimation(name: "preloader")
        //loadAnimation(name: "1158-sleeping")
        
        loadAnimation(name: "1158-sleeping", edit: [
            LottieEdit(original: "[0,0.356862745098,0.666666666667,1]", edited: "[0,0,0,1]")
        ])
        
    }
    
    struct LottieEdit{
        let original : String
        let edited : String
    }
    
    private func loadAnimation(name : String, edit : [LottieEdit]){
        //read file
        guard let jsonFileURL = Bundle.main.url(forResource: name, withExtension: "json"),
            let data = try? Data(contentsOf: jsonFileURL),
            var jsonString = String(data: data, encoding: .utf8)
        else {
            return
        }
        
        //edit json string
        for editItem in edit{
            jsonString = jsonString.replacingOccurrences(of: editItem.original, with: editItem.edited)
        }
        
        //write json string to disk
        let filename = UUID().uuidString + ".json"
        let nsData = (jsonString.data(using: .utf8) ?? Data()) as NSData
        
        let newFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
        
        nsData.write(to: newFileURL, atomically: true)
        
        //load
        
        let animationView = AnimationView(filePath: newFileURL.path)
        
        animationView.contentMode = .scaleAspectFill
        animationView.frame = animationContainerView.bounds
        animationView.loopMode = .autoReverse
        //animationContainerView.embed(view: animationView)
        animationContainerView.addSubview(animationView)
        
        animationView.play()
        
        //animationView.transform = .init(scaleX: 0.5, y: 0.5)
        
        self.animationView = animationView
        
        try? FileManager.default.removeItem(at: newFileURL)
        
    }
 
    private func loadAnimation(name : String){
        let animationView = AnimationView(name: name)
        animationView.contentMode = .scaleAspectFill
        animationView.frame = animationContainerView.bounds
        animationView.loopMode = .autoReverse
        //animationContainerView.embed(view: animationView)
        animationContainerView.addSubview(animationView)
        
        animationView.play()
        
        //animationView.transform = .init(scaleX: 0.5, y: 0.5)
        
        self.animationView = animationView
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        animationView?.frame = animationContainerView.bounds
        animationView?.stop()
        animationView?.play()
    }
    
    
    func loadInitialData(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) { [weak self] in
            self?.finishedLoadingData()
        }
    }
    
    func finishedLoadingData(){
        
        //show Main.storyboard
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = mainStoryboard.instantiateInitialViewController()
        
        UIApplication.shared.delegate?.window??.rootViewController = rootVC
        
    }
    

}
