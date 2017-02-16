//
//  GameScene.swift
//  SpaceCannon
//
//  Created by Yonglin Ma on 2/15/17.
//  Copyright © 2017 Sixlivesleft. All rights reserved.
//

import SpriteKit
import GameplayKit

let SHOOT_SPEED : CGFloat = 1000.0

class GameScene: SKScene {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKSpriteNode?

    private var mainLayer : SKNode?
    private var cannon : SKSpriteNode?
    private var didShoot = false
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
        
        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//        
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//            
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
        
//        let cannon2 = SKSpriteNode(imageNamed: "Cannon")
//        cannon2.position = CGPoint(x: 100, y: 100)
//        cannon2.run(SKAction.repeatForever(
//            SKAction.sequence([SKAction.rotate(byAngle: CGFloat(M_PI), duration: 2),
//                               SKAction.rotate(byAngle: -(CGFloat)(M_PI), duration: 2)])
//            ))
//        self.addChild(cannon2)
        
        mainLayer = SKNode()
        
        self.cannon = self.childNode(withName: "cannon") as? SKSpriteNode
        if let cannon = self.cannon {
            cannon.run(SKAction.repeatForever(
                SKAction.sequence([SKAction.rotate(byAngle: CGFloat(Float.pi), duration: 2),
                                SKAction.rotate(byAngle: -(CGFloat)(Float.pi), duration: 2)])
            ))
        }
        
        self.addChild(mainLayer!)
        
    }
    
    func radiansToVector(radians : CGFloat) -> CGVector {
        var vector = CGVector()
        vector.dx = CGFloat(cosf(Float(radians)))
        vector.dy = CGFloat(sinf(Float(radians)))
        return vector
    }
    
    func shoot() {
        guard let cannon = self.cannon else { return }
        
        let ball = SKSpriteNode(imageNamed: "Ball")
        ball.name = "ball"
        ball.xScale = 2.0
        ball.yScale = 2.0
        let rotationVector = radiansToVector(radians: (cannon.zRotation))
        ball.position = CGPoint(x: (cannon.position.x + cannon.size.width * 0.5 * rotationVector.dx),
                                y: (cannon.position.y + cannon.size.height * 0.5 * rotationVector.dy))
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 6.0)
        
        ball.physicsBody?.velocity = CGVector(dx: rotationVector.dx * SHOOT_SPEED, dy: rotationVector.dy * SHOOT_SPEED)
        mainLayer?.addChild(ball)
        
    }
    
    //MARK: Frame life cycle
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    override func didEvaluateActions() {
        // code
    }
    override func didSimulatePhysics() {
        if didShoot {
            shoot()
            didShoot = false
        }
        // Clean up balls
        mainLayer?.enumerateChildNodes(withName: "ball", using: { (node, stop) in
            if  !self.frame.contains(node.position) {
                node.removeFromParent()
            }
        })
    }
    
    override func didApplyConstraints() {
        //<#code#>
    }
    override func didFinishUpdate() {
        //<#code#>
    }
    
    
    //MARK: - Touch handling
    
    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        didShoot = true
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
}