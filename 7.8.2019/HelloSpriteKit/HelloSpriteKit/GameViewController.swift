//
//  GameViewController.swift
//  HelloSpriteKit
//
//  Created by Benny Davidovitz on 07/08/2019.
//  Copyright © 2019 HackerU. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    
    private func setupGame(){
        guard let skView = self.view as? SKView else{ return }
        
        //let scene = SampleScene(size: skView.bounds.size)
        let scene = BallScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        skView.ignoresSiblingOrder = true
        
        skView.presentScene(scene)
        
        skView.showsFPS = true
        skView.showsNodeCount = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGame()
//
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
