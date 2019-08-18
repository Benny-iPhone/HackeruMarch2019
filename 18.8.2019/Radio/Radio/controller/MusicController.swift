//
//  MusicController.swift
//  Radio
//
//  Created by Benny Davidovitz on 18/08/2019.
//  Copyright © 2019 HackerU. All rights reserved.
//

import Foundation
import AVFoundation

protocol PlayableItem {
    var streamingUrl : URL{ get }
}

class MusicController{
    static let shared = MusicController()
    private var player : AVPlayer?
    
    var isPlaying : Bool{
        guard let player = self.player else{ return false }
        return player.timeControlStatus == .playing
    }
    
    func play(item : PlayableItem){
        self.player = AVPlayer(url: item.streamingUrl)
        self.player?.play()
        
        try? AVAudioSession.sharedInstance().setActive(true, options: .init())
        try? AVAudioSession.sharedInstance().setCategory(.playback)
    }
    
    func pause(){
        player?.pause()
    }
    
    func set(volume : Float){
        player?.volume = volume
    }
}
