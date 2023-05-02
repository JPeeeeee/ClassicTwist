//
//  GuitarGameScene.swift
//  WWDC23
//
//  Created by João Pedro Vieira Santos on 16/04/23.
//

import Foundation
import SpriteKit
class GuitarGameScene: SKScene {
    private var guitar: SKSpriteNode!
    private var palco: SKSpriteNode!
    
    private var guitar_game_hint: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        let hint_animation_fade_in = SKAction.fadeIn(withDuration: 0.5)
        let hint_bounce = SKAction.sequence([SKAction.scale(to: 1.2, duration: 0.5), SKAction.scale(to: 1, duration: 0.5)])
        
        guitar_game_hint = SKSpriteNode(imageNamed: "guitarGameHint")
        guitar_game_hint.size = CGSize(width: guitar_game_hint.size.width * 0.9, height: guitar_game_hint.size.height * 0.9)
        guitar_game_hint.position = CGPoint(x: frame.midX, y: frame.midY * 1.7)
        guitar_game_hint.zPosition = 0
        guitar_game_hint.alpha = 0

        palco = SKSpriteNode(imageNamed: "palcoMinigame")
        palco.size = CGSize(width: frame.width, height: frame.height)
        palco.position = CGPoint(x: frame.midX, y: frame.midY)
        palco.zPosition = -1
        
        guitar = SKSpriteNode(imageNamed: "violaoFixed")
        guitar.size = CGSize(width: guitar.size.width, height: guitar.size.height)
        guitar.position = CGPoint(x: frame.midX, y: frame.midY * 0.8)
        guitar.zPosition = 0
        
        let bounce = SKAction.sequence([SKAction.moveTo(y: guitar.position.y + 7, duration: 1.2), SKAction.moveTo(y: guitar.position.y - 7, duration: 1.2)])
        bounce.timingMode = .easeInEaseOut
        let bouncing_violao = SKAction.repeatForever(bounce)
        
        addChild(guitar)
        addChild(palco)
        addChild(guitar_game_hint)
        
        guitar_game_hint.run(hint_animation_fade_in)
        guitar_game_hint.run(hint_bounce)
        guitar.run(bouncing_violao)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)

        if guitar.contains(location) {
            let transition = SKTransition.crossFade(withDuration: 1.5)
            let newScene = FocusedGuitarGameScene()
            newScene.size = CGSize(width: 1366, height: 1024)
            newScene.scaleMode = .aspectFit
            
            scene?.view?.presentScene(newScene, transition: transition)
        }
    }
}
