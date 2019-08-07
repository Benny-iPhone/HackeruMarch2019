//
//  BallScene.swift
//  HelloSpriteKit
//
//  Created by Benny Davidovitz on 07/08/2019.
//  Copyright © 2019 HackerU. All rights reserved.
//

import SpriteKit

class BallScene: SKScene {
    
    enum Collision : UInt32{
        case ball = 1 //0001
        case ground = 2 //0010
        case paddle = 4 //0100
        case brick = 8 //1000
        case edge = 16 //10000
        
    }
    
    var balls : [SKNode] = []
    weak var paddle : SKSpriteNode!
    var isTouchingPaddle : Bool = false
    
    override func didMove(to view: SKView) {
        setupBackground()
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = Collision.edge.rawValue
        self.physicsBody?.friction = 0
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        createPaddle()
        createFloor()
    }
    
    private func setupBackground(){
        let bg = SKSpriteNode(imageNamed: "background")
        bg.size = self.size
        
        let centerPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        bg.position = centerPoint
        bg.zPosition = -1
        
        self.addChild(bg)
    }
    
    
    private func createFloor(){
        let rect = CGRect(x: 0, y: paddle.size.height * 2, width: self.size.width, height: 1)
        let node = SKNode()
        node.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
        node.physicsBody?.categoryBitMask = Collision.ground.rawValue
        node.physicsBody?.collisionBitMask = Collision.ball.rawValue
        self.addChild(node)
    }
    
    private func createPaddle(){
        let node = SKSpriteNode(imageNamed: "paddleBlu")
        
        node.position.x = self.frame.size.width / 2
        node.position.y = node.size.height * 3
        node.zPosition = 100
        
        let physicsBody = SKPhysicsBody(rectangleOf: node.size)
        physicsBody.friction = 0
        physicsBody.restitution = 1
        physicsBody.isDynamic = false //static, will not move by collision
        physicsBody.categoryBitMask = Collision.paddle.rawValue
        physicsBody.collisionBitMask = Collision.ball.rawValue
        node.physicsBody = physicsBody
        
        self.addChild(node)
        self.paddle = node
    }
    
    private func spwanBall(at position : CGPoint){
        guard balls.count < 1 else { return }
        
        let node = SKSpriteNode(imageNamed: "icons8-pokeball")
        node.position = position
        node.zPosition = 100
        
        let physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        physicsBody.affectedByGravity = true
        physicsBody.isDynamic = true
        physicsBody.allowsRotation = true
        physicsBody.restitution = 1
        physicsBody.friction = 0
        physicsBody.linearDamping = 0
        physicsBody.angularDamping = 0
        physicsBody.categoryBitMask = Collision.ball.rawValue
        physicsBody.collisionBitMask = Collision.paddle.rawValue | Collision.ground.rawValue | Collision.edge.rawValue
        physicsBody.contactTestBitMask = Collision.ground.rawValue
        node.physicsBody = physicsBody
        
        
        self.addChild(node)
        
        node.physicsBody?.applyImpulse(CGVector(dx: 50, dy: -50))
        
        self.balls.append(node)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let p = touches.first?.location(in: self) else { return }
        
        if paddle.frame.contains(p){
            isTouchingPaddle = true
        } else {
            spwanBall(at: p)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouchingPaddle = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouchingPaddle = false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let p = touches.first?.location(in: self) else { return }
        
        if isTouchingPaddle{
            paddle.position.x = p.x
        }
    }
}

extension BallScene : SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let mask1 = Collision(rawValue:contact.bodyA.categoryBitMask),
            let mask2 = Collision(rawValue:contact.bodyB.categoryBitMask) else{
                return
        }
        
        if mask1 == .ground && mask2 == .ball{
            let node = contact.bodyB.node!
            let emitter = SKEmitterNode(fileNamed: "Spark.sks")!
            emitter.position = node.position
            self.addChild(emitter)
            
            print("ball touch ground")
            node.run(SKAction.sequence([
                SKAction.playSoundFileNamed("effect.wav", waitForCompletion: false),
                SKAction.run { self.balls = [] },
                SKAction.removeFromParent()
                
                ]))
            
            emitter.run(SKAction.sequence([
                SKAction.wait(forDuration: 0.4),
                SKAction.removeFromParent()
                ]))
            
        }
        
    }
    
}
