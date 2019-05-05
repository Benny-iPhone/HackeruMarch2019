//
//  PianoKeypadView.swift
//  Piano
//
//  Created by hackeru on 05/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class PianoKeypadView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupPanGesture()
        setupTapGesture()
    }

    private func setupTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureAction(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    private func setupPanGesture(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(gestureAction(_:)))
        panGesture.maximumNumberOfTouches = 10
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func gestureAction(_ sender : UIGestureRecognizer){
        for i in 0..<sender.numberOfTouches{
            let point = sender.location(ofTouch: i, in: self)
            handleTouch(at: point)
        }
    }
    
    private func handleTouch(at point : CGPoint){
        guard let noteView = self.hitTest(point, with: nil) as? NoteView else{
            return
        }
        
        noteView.play()
    }
    
    
    
    
    
}
