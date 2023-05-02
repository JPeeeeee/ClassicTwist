//
//  AndSceneScene.swift
//  WWDC23
//
//  Created by João Pedro Vieira Santos on 19/04/23.
//

import Foundation
import SpriteKit

class AndScene: SKScene {
    private var background: SKSpriteNode!
    
    private var thanks_text: SKLabelNode!
    private var play_again: SKSpriteNode!
    
    private var soundManager = SoundManager()
    
    override func didMove(to view: SKView) {
        
        let bounce = SKAction.sequence([SKAction.scale(to: 1.1, duration: 1), SKAction.scale(to: 1, duration: 1)])
        let bouncing_forever = SKAction.repeatForever(bounce)
        
        background = SKSpriteNode(texture: SKTexture(imageNamed: "cortina"), size: CGSize(width: frame.width, height: frame.height))
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        
        thanks_text = SKLabelNode(fontNamed: "AvenirNext-Bold")
        thanks_text.text = "Thank you for playing!"
        thanks_text.position = CGPoint(x: frame.midX, y: frame.midY)
        thanks_text.fontSize = 65
        thanks_text.fontColor = .white
        thanks_text.alpha = 0
        
        play_again = SKSpriteNode(imageNamed: "buttonPlayAgain")
        play_again.size = CGSize(width: play_again.size.width, height: play_again.size.height)
        play_again.position = CGPoint(x: frame.midX, y: frame.midY * 0.5)
        play_again.alpha = 0
        
        addChild(background)
        addChild(play_again)
        addChild(thanks_text)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.soundManager.play(sound: .palmas)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.thanks_text.run(SKAction.fadeIn(withDuration: 0.5))
            self.play_again.run(SKAction.fadeIn(withDuration: 0.5))
            self.play_again.run(bouncing_forever)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        if play_again.contains(location) {
            
            play_again.run(SKAction.sequence([SKAction.scale(to: 0.8, duration: 0.2), SKAction.scale(to: 1, duration: 0.2)]))
            play_again.run(SKAction.fadeOut(withDuration: 0.5))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let transition_close_curtain = SKTransition.doorsCloseHorizontal(withDuration: 1.5)
                let newScene = CurtainTransitionScene()
                newScene.set(newScene: StartScreen())
                newScene.size = CGSize(width: 1366, height: 1024)
                newScene.scaleMode = .aspectFit
                
                self.scene?.view?.presentScene(newScene, transition: transition_close_curtain)
            }
        }
    }
}
