//
//  GameScene.swift
//  InvaderSomething
//
//  Created by Benny Davidovitz on 14/08/2019.
//  Copyright © 2019 HackerU. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    enum Category : UInt32{
        case boundary = 1
        case player = 2
        case bullet = 4
        case enemy = 8
        case virtualWall = 16
    }
    
    struct Logic{
        var isPlaying : Bool = false
        var isTouchingPlayer : Bool = false
        var score : Int = 0
        
        var canSpawnEnemy : Bool{
            return isPlaying
        }
        
        var canMovePlayer : Bool{
            return isPlaying && isTouchingPlayer
        }
        
        var canFire : Bool{
            return isPlaying && isTouchingPlayer
        }
        
    }
    
    var logic = Logic()
    
    weak var player : SKSpriteNode!
    weak var scoreLabel : SKLabelNode!
    var spawnEnemyTimer : Timer?
    var fireBulletsTimer : Timer?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let node = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.frame.width, height: 1))
        node.position = CGPoint(x: 0, y: self.frame.height - 60)
        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        physicsBody.isDynamic = false
        physicsBody.categoryBitMask = Category.virtualWall.rawValue
        node.physicsBody = physicsBody
        self.addChild(node)
        
        createScoreLabel()
        setupBackground()
        startGame()
        setupPhysicWorld()
        
        self.run(SKAction.playSoundFileNamed("fire", waitForCompletion: false))
    }
    
    //MARK: - Setup
    
    private func createScoreLabel(){
        let label = SKLabelNode(text: "Score 0")
        label.fontName = "ChalkboardSE-Bold"
        label.fontSize = 24
        label.fontColor = .white
        
        label.position = CGPoint(x: 80, y: 80)
        
        self.addChild(label)
        
        self.scoreLabel = label
    }
    
    func setupPhysicWorld(){
        
        let body = SKPhysicsBody(edgeLoopFrom: self.frame)
        body.categoryBitMask = Category.boundary.rawValue
        body.friction = 0
        
        self.physicsBody = body
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
    }
    
    private func spawnBullets(){
        guard logic.canFire else{ return }
        
        
        let size = CGSize(width: 2, height: 20)
        let bullet = SKShapeNode(rectOf: size)
        bullet.position = CGPoint(x: player.position.x, y: player.position.y + player.size.height)
        bullet.fillColor = .white
        
        let body = SKPhysicsBody(rectangleOf: size)
        body.categoryBitMask = Category.bullet.rawValue
        body.contactTestBitMask = Category.enemy.rawValue | Category.virtualWall.rawValue
        body.friction = 0
        bullet.physicsBody = body
        
        self.addChild(bullet)
        bullet.run(SKAction.playSoundFileNamed("fire", waitForCompletion: false))
        bullet.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
        /*
        bullet.run(SKAction.sequence([
            SKAction.playSoundFileNamed("fire", waitForCompletion: false),
            SKAction.moveBy(x: 0, y: frame.size.height, duration: 1),
            SKAction.removeFromParent() //kill bullet
            ]))*/
        
    }
    
    private func spawnEnemy()
    {
        guard logic.canSpawnEnemy else{ return }
        
        let enemy = SKSpriteNode(imageNamed: "enemy")
        
        let xDelta = enemy.size.width / 2
        let maxY = frame.height - enemy.size.height / 2
        let x = CGFloat.random(in: xDelta...(self.frame.width - xDelta))
        let y = CGFloat.random(in: (maxY - 100)...maxY)
        
        enemy.position = CGPoint(x: x, y: y)
        
        let body = SKPhysicsBody(texture: enemy.texture!, size: enemy.size)
        body.categoryBitMask = Category.enemy.rawValue
        body.contactTestBitMask = Category.bullet.rawValue | Category.enemy.rawValue | Category.boundary.rawValue | Category.virtualWall.rawValue
        body.friction = 0
        
        enemy.physicsBody = body
        
        self.addChild(enemy)
    }
    
    private func createPlayer(){
        let player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: self.frame.midX ,y: player.size.height * 0.5 + 40)
        
        let body = SKPhysicsBody(texture: player.texture!, size: player.size)
        body.friction = 0
        body.categoryBitMask = Category.player.rawValue
        body.isDynamic = false
        
        player.physicsBody = body
        
        self.addChild(player)
        self.player = player
    }
    
    private func setupBackground(){
        self.backgroundColor = .black
    }
    
    //MARK: - Game
    
    func startGame(){
        self.logic.isPlaying = true
        
        createPlayer()

        spawnEnemyTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { [weak self](_) in
            self?.spawnEnemy()
        })
    }
    
    func pauseGame(){
        
        self.logic.isPlaying = false
        
        spawnEnemyTimer?.invalidate()
        spawnEnemyTimer = nil
    }
    
    private func playerTouched(){
        logic.isTouchingPlayer = true
        self.fireBulletsTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] _ in
            self?.spawnBullets()
        })
    }
    
    private func playerUnTouched(){
        logic.isTouchingPlayer = false
        fireBulletsTimer?.invalidate()
        fireBulletsTimer = nil
    }
    
    //MARK: - User Interaction
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {
            return
        }
        
        if player.frame.contains(point){
            playerTouched()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {
            return
        }
        
        if logic.canMovePlayer{
            let halfSize = player.size.width / 2
            let x = min(max(halfSize,point.x),self.frame.width - halfSize)
            player.position.x = x
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerUnTouched()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerUnTouched()
    }
    
}

extension GameScene : SKPhysicsContactDelegate{
    
    private func refreshScore(){
        scoreLabel.text = "Score \(logic.score)"
    }
    
    private func bulletHitEnemy(with contact : SKPhysicsContact){
        guard let nodeA = contact.bodyA.node,
            let nodeB = contact.bodyB.node else{ return }
        
        guard nodeA.parent != nil && nodeB.parent != nil else{ return }
        
        self.logic.score += 1
        refreshScore()
        
        
        let emitter = SKEmitterNode(fileNamed: "spark.sks")!
        emitter.position = nodeA.position
        emitter.zPosition = 100
        self.addChild(emitter)
        
        nodeA.removeFromParent()
        nodeB.removeFromParent()
        
        
        
        emitter.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.4),
            SKAction.removeFromParent()
            ]))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
       
        if contact.bodyA.categoryBitMask == Category.enemy.rawValue && contact.bodyB.categoryBitMask == Category.bullet.rawValue{
            print("bullet hit enemy")
            bulletHitEnemy(with: contact)
            return
        }
        
        if contact.bodyB.node is SKShapeNode && contact.bodyA.categoryBitMask == Category.virtualWall.rawValue{
            //print(contact.bodyA.categoryBitMask)
            if contact.bodyB.node?.parent != nil{
                contact.bodyB.node?.removeFromParent()
            }
        }
    }
    
}
