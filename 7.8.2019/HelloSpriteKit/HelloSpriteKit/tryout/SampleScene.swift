//
//  SampleScene.swift
//  HelloSpriteKit
//
//  Created by Benny Davidovitz on 07/08/2019.
//  Copyright © 2019 HackerU. All rights reserved.
//

import SpriteKit

class SampleScene: SKScene {

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.backgroundColor = .orange
        
        let centerPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        createLabel(with: "Sprite Kit 😍", at: centerPoint)
        
        addSprite(with: "spaceship", at: centerPoint)
        setupBackground()
    }
    
    private func setupBackground(){
        let bg = SKSpriteNode(imageNamed: "background")
        bg.size = self.size
        
        let centerPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        bg.position = centerPoint
        bg.zPosition = -1
        
        self.addChild(bg)
    }
    
    private func addSprite(with name : String, at position : CGPoint){
        
        let sprite = SKSpriteNode(imageNamed: name)
        sprite.position = position
        sprite.zPosition = 1
        sprite.xScale = 0.1
        sprite.yScale = 0.1
        sprite.zRotation = CGFloat.pi * 0.25
        
        sprite.name = "spaceship"
        
        self.addChild(sprite)
        
    }
    
    @discardableResult
    private func createLabel(with text : String, at position : CGPoint) -> SKNode{
        
        let label = SKLabelNode(text: text)
        label.fontName = "Copperplate"
        label.fontSize = 48
        label.fontColor = .white
        
        label.position = position
        
        self.addChild(label)
        
        return label
        
    }
    
    var count = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if let spaceship = self.childNode(withName: "spaceship") as? SKSpriteNode{
            spaceship.xScale += 0.1
            spaceship.yScale += 0.1
            spaceship.zRotation += CGFloat.pi * 0.1
        }
        
        guard let point = touches.first?.location(in: self) else{ //CGPoint of touch
            return
        }
        
        count += 1
        let label = createLabel(with: "#\(count)", at: point)
        
        let seq = SKAction.sequence([
            SKAction.moveBy(x: 100, y: 0, duration: 1),
            SKAction.rotate(byAngle: .pi, duration: 1),
            SKAction.moveBy(x: 0, y: -100, duration: 1),
            SKAction.customAction(withDuration: 1, actionBlock: { (node, val) in
                (node as? SKLabelNode)?.fontColor = .black
            }),
            SKAction.fadeOut(withDuration: 2),
            SKAction.removeFromParent()
            ])
        
        label.run(seq)
        
//        label.run(SKAction.fadeOut(withDuration: 2)) {
//            label.removeFromParent()
//        }
        //label.run(SKAction.fadeOut(withDuration: 2))
    }
    
}
