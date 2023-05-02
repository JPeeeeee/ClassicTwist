//
//  CurtainTrasitionScene.swift
//  WWDC23
//
//  Created by João Pedro Vieira Santos on 13/04/23.
//

import SpriteKit

class CurtainTransitionScene: SKScene {
    private var background: SKSpriteNode!
    
    private var newScene: SKScene? 
    
    private var soundManager = SoundManager()
    
    func set(newScene: SKScene) {
        self.newScene = newScene
    }
    
    private func go_to_next_scene (){
        let transition_open_curtain = SKTransition.doorsOpenHorizontal(withDuration: 1.5)
        guard let newScene = newScene else { return }
        newScene.size = CGSize(width: 1366, height: 1024)
        newScene.scaleMode = .aspectFit
        
        soundManager.play(sound: .correiaCortina)
        
        scene?.view?.presentScene(newScene, transition: transition_open_curtain)
    }
     
    override func didMove(to view: SKView) {
        background = SKSpriteNode(texture: SKTexture(imageNamed: "cortina"), size: CGSize(width: frame.width, height: frame.height))
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(background)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.go_to_next_scene()
        }
    }
}
