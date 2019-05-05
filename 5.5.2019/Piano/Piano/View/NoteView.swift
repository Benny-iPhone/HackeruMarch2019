//
//  NoteView.swift
//  Piano
//
//  Created by hackeru on 05/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import AVFoundation

class NoteView: UIView {
    var player : AVAudioPlayer?
    @IBInspectable var note : String = "" //c1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadPlayer()
        //self.isUserInteractionEnabled = false
        //setupTapGesture()
    }
    /*
    private func setupTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(play))
        self.addGestureRecognizer(tapGesture)
    }
    */
    private func loadPlayer(){
        guard let url = Bundle.main.url(forResource: note, withExtension: "mp3") else{
            return
        }
        self.player = try? AVAudioPlayer(contentsOf: url)
        
    }
    
    @objc func play(){
        player?.play()
    }
}
