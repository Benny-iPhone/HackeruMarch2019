//
//  ViewController.swift
//  Localizations
//
//  Created by hackeru on 19/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var playAudioButton: UIButton!
    var player : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(NSLocalizedString("key", comment: "key"))
        localizeUI()
    }
    
    private func localizeUI(){
        greetingLabel.text = "mainVC.titleLabel".translated
        
        playAudioButton.setTitle("mainVC.button.playAudio".translated, for: .normal)
        
        //greetingLabel.text = NSLocalizedString("mainVC.titleLabel", comment: "")
    }

    @IBAction func playAudioAction(_ sender: Any) {
        
        if player == nil{
            guard let url = Bundle.main.url(forResource: "sound", withExtension: "wav") else{ return }
            player = try? AVAudioPlayer(contentsOf: url)
        }
        
        player?.play()
        
    }
    
}

